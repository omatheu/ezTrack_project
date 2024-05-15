# O que falta fazer nesse código:
# 1. Arrumar a questão do id da transação, atualmente há apenas o product_id
# 2. Arrumar a função de calcular a média de preço de um produto 

from os import environ
import logging
import requests
import numpy as np
import json
import traceback

class Transaction:
    # Definição da classe Transaction para representar uma transação
    def __init__(self, sender: str, receiver: str, product_id: str, price: int, timestamp: int):
        # Inicialização de uma transação com os atributos fornecidos
        self.sender = sender
        self.receiver = receiver
        self.product_id = product_id
        self.price = price
        self.timestamp = timestamp

    def to_dict(self):
        # Método para converter os atributos da transação em um dicionário
        return {
            "sender": self.sender,
            "receiver": self.receiver,
            "product_id": self.product_id,
            "price": self.price,
            "timestamp": self.timestamp
        }

# Endereço do proprietário do sistema
owner = "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266"

# Listas para armazenar transações confirmadas e não confirmadas, e lista de usuários
confirmed_transactions = []
not_confirmed_transactions = []
users_list = []

# Configuração do registro de log
logging.basicConfig(level="INFO")
logger = logging.getLogger(__name__)

# URL do servidor HTTP rollup, com fallback para um valor padrão
rollup_server = environ.get(
    "ROLLUP_HTTP_SERVER_URL", "http://127.0.0.1:8080/rollup")
logger.info(f"HTTP rollup_server url is {rollup_server}")

# Funções de utilidade para conversão entre diferentes formatos de dados

def str2hex(string):
    # Converte uma string para hexadecimal
    return binary2hex(str2binary(string))

def str2binary(string):
    # Converte uma string para binário
    return string.encode("utf-8")

def binary2hex(binary):
    # Converte um objeto binário para hexadecimal
    return "0x" + binary.hex()

def hex2binary(hexstr):
    # Converte uma string hexadecimal para binário
    return bytes.fromhex(hexstr[2:])

def hex2str(hexstr):
    # Converte uma string hexadecimal para string
    return hex2binary(hexstr).decode("utf-8")

# Funções para enviar dados via requisições HTTP

def send_notice(notice: str) -> None:
    # Envia uma notificação via requisição POST
    send_post("notice", notice)

def send_report(report: str) -> None:
    # Envia um relatório via requisição POST
    send_post("report", report)

def send_post(endpoint, json_data) -> None:
    # Envia uma requisição POST para um determinado endpoint
    response = requests.post(rollup_server + f"/{endpoint}", json=json_data)
    logger.info(
        f"/{endpoint}: Received response status {response.status_code} body {response.content}")

# Manipuladores de solicitações recebidas

def handle_advance(data):
    # Manipula solicitações de avanço de estado
    logger.info(f"Receiving advance request with data {hex2str(data['payload'])} from {data['metadata']['msg_sender']}")
    binary = hex2str(data['payload'])
    json_data = json.loads(binary)
    logger.info(f"Received json data {json_data}")
    try:
        if json_data["method"] == "addNewUser" and data["metadata"]["msg_sender"] == owner.lower():
            # Adiciona um novo usuário à lista
            users_list.append(json_data["data"])
            notice_payload = {"payload": str2hex(f'Add new user {data["payload"]} to the list of users')}
            send_notice(notice_payload)
            return "accept"
        elif json_data["method"] == "addNewTransaction":
            # Adiciona uma nova transação à lista de não confirmadas
            tx = Transaction(
                sender= data["metadata"]["msg_sender"],
                receiver= json_data["data"]["receiver"].lower(),
                product_id= json_data["data"]["product_id"],
                price= json_data["data"]["price"],
                timestamp= json_data["data"]["timestamp"]
            )
            not_confirmed_transactions.append(tx)
            notice_payload = {"payload": str2hex(f'Add new transaction {data["payload"]} to the list of not confirmed transactions')}
            send_notice(notice_payload)
            return "accept"
        elif json_data["method"] == "deleteUser" and data["metadata"]["msg_sender"] == owner.lower():
            # Remove um usuário da lista
            users_list.remove(json_data["data"])
            notice_payload = {"payload": str2hex(f'Delete user {data["payload"]} from the list of users')}
            send_notice(notice_payload)
            return "accept"
        elif json_data['method'] == "validateTransaction":
            # Valida uma transação
            for transaction in not_confirmed_transactions:
                if str(transaction.product_id) == str(json_data["data"]):
                    if str(transaction.receiver) == str(data["metadata"]["msg_sender"]):
                        confirmed_transactions.append(transaction)
                        not_confirmed_transactions.remove(transaction)
                        notice_payload = {"payload": str2hex(f'Transaction {data["payload"]} confirmed')}
                        send_notice(notice_payload)
            return "accept"
    except Exception as e:
        # Manipula exceções
        msg = f"Error {e} processing data {data}"
        logger.error(f"{msg}\n{traceback.format_exc()}")
        send_report({"payload": str2hex(msg)})
        return "reject"

def handle_inspect(data):
    # Manipula solicitações de inspeção de estado
    logger.info(f"Received inspect request data {data}")
    binary = hex2str(data['payload'])
    try:
        if binary == "users":
            # Responde com a lista de usuários
            users_data = ",".join(users_list)
            report_payload = {"all_users": f"{users_data}"}
            send_report({"payload": str2hex(f'{report_payload}')})
            return "accept"
        if binary == "transactions/confirmed":
            # Responde com a lista de transações confirmadas
            confirmed_transactions_data = [transaction.to_dict() for transaction in confirmed_transactions]
            report_payload = {"confirmed_transactions": f"{confirmed_transactions_data}"}
            send_report({"payload": str2hex(f'{report_payload}')})
            return "accept"
        if binary == "transactions/not_confirmed":
            # Responde com a lista de transações não confirmadas
            not_confirmed_transactions_data = [transaction.to_dict() for transaction in not_confirmed_transactions]
            report_payload = {"not_confirmed_transactions": f"{not_confirmed_transactions_data}"}
            send_report({"payload": str2hex(f'{report_payload}')})
            return "accept"

        # Calcula a média de preço de um produto específico
        if binary.split('/')[0] == 'mean':
            product_id = binary.split('/')[1]
            product_prices_by_id = []
            for transaction in confirmed_transactions:
                if transaction.product_id == product_id:
                    product_prices_by_id.append(transaction.price)
                if product_prices_by_id:
                    # Calcula a média de preço
                    mean_price = np.mean(product_prices_by_id)
                    report_payload = {"product_id": product_id,
                                      "mean_price": mean_price}
                    # Envia o relatório
                    send_report({"payload": str2hex(json.dumps(report_payload))}) # Convert to json before sending
                    return "accept"
                else:
                    # Se não houver transações para o produto, envia uma mensagem de erro
                    msg = f"No transactions found for product {product_id}"
                    logger.error(f'{msg}\n{traceback.format_exc()}')
                    send_report({"payload": str2hex(msg)})
                    return "reject"
    except Exception as e:
        # Manipula exceções
        msg = f"Error {e} processing data {data}"
        logger.error(f"{msg}\n{traceback.format_exc()}")
        send_report({"payload": str2hex(msg)})
        return "reject"

# Mapeamento de manipuladores de acordo com o tipo de solicitação
handlers = {
    "advance_state": handle_advance,
    "inspect_state": handle_inspect,
}

# Configuração do estado final da solicitação
finish = {"status": "accept"}

# Loop principal para processar solicitações continuamente
while True:
    logger.info("Sending finish")
    response = requests.post(rollup_server + "/finish", json=finish)
    logger.info(f"Received finish status {response.status_code}")
    if response.status_code == 202:
        logger.info("No pending rollup request, trying again")
    else:
        rollup_request = response.json()
        data = rollup_request["data"]
        handler = handlers[rollup_request["request_type"]]
        finish["status"] = handler(rollup_request["data"])
