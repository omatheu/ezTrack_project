// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Contrato inteligente para gerenciar transações de cotação entre vendedores e compradores.
// Principais regras de negócio:
// - Apenas compradores podem cadastrar transações.
// - Apenas vendedores podem validar transações.
// - Cadastro de usuários (vendedores e compradores) é feito pelo proprietário do contrato.
// - Remoção de usuários (vendedores e compradores) é feita pelo proprietário do contrato.
// - Cálcular o preço médio das transações validadas.
// - Mostrar todas as transações.
// - Evento para registrar uma nova transação.

contract ProcessoCotacao {
    // Enumeração para representar os tipos de usuário: Vendedor ou Comprador.
    enum TipoUsuario { Vendedor, Comprador }

    // Mapeamento para armazenar o tipo de cada usuário, onde a chave é o endereço Ethereum do usuário.
    mapping(address => TipoUsuario) private usuarios;

    // Endereço do proprietário do contrato (quem fez o deploy do contrato).
    address public proprietario;

    // Estrutura de dados para representar uma transação.
    struct Transacao {
        uint idProduto; // Identificador único do produto.
        string dataTransacao; // Data da transação.
        uint valorTransacao; // Valor da transação.
        uint quantidade; // Quantidade do produto transacionada.
        bytes32 fornecedor; // Nome do fornecedor.
        bytes32 comprador; // Nome do comprador.
        TipoUsuario tipoComprador; // Tipo do comprador (Vendedor ou Comprador).
        bool validada; // Indica se a transação foi validada.
    }

    // Evento emitido quando uma nova transação é registrada.
    event NovaTransacaoRegistrada(uint idProduto, string dataTransacao, uint valorTransacao, uint quantidade, bytes32 fornecedor, bytes32 comprador, TipoUsuario tipoComprador, bool validada);

    // Array para armazenar todas as transações registradas no contrato.
    Transacao[] public transacoes;

    // Construtor do contrato. Define o endereço do proprietário como o endereço que fez o deploy do contrato.
    constructor() {
        proprietario = msg.sender;
    }

    // Função para registrar um novo usuário no contrato, definindo o tipo do usuário. Regra de negócio: cadastro de usuários é feito pelo proprietário do contrato.
    function registrarUsuario(address _usuario, TipoUsuario _tipoUsuario) public {
        // Apenas o proprietário pode registrar usuários.
        require(msg.sender == proprietario, "Somente o proprietario pode registrar usuarios");
        usuarios[_usuario] = _tipoUsuario; // Atribui o tipo de usuário ao endereço fornecido.
    }

    // Função para cadastrar uma nova transação no contrato. Regra de negócio: apenas compradores podem cadastrar transações.
    function cadastrarTransacao(uint _idProduto, string memory _dataTransacao, uint _valorTransacao, uint _quantidade, bytes32 _fornecedor, bytes32 _comprador, TipoUsuario _tipoComprador) external returns (bool) {
        // Apenas compradores podem cadastrar transações.
        require(usuarios[msg.sender] == TipoUsuario.Comprador, "Somente compradores podem cadastrar transacoes.");
        // Cria uma nova transação e a adiciona ao array de transações.
        Transacao memory novaTransacao = Transacao({
            idProduto: _idProduto,
            dataTransacao: _dataTransacao,
            valorTransacao: _valorTransacao,
            quantidade: _quantidade,
            fornecedor: _fornecedor,
            comprador: _comprador,
            tipoComprador: _tipoComprador,
            validada: false // Define a transação como não validada ao cadastrá-la.
        });
        transacoes.push(novaTransacao);
        // Emite um evento informando que uma nova transação foi registrada.
        emit NovaTransacaoRegistrada(_idProduto, _dataTransacao, _valorTransacao, _quantidade, _fornecedor, _comprador, _tipoComprador, false);
        return true;
    }

    // Função para mostrar todas as transações. Regra de negócio: visualização de todas as transações é permitida para qualquer usuário.
    function mostrarTransacoes() external view returns (Transacao[] memory) {
        return transacoes;
    }

    // Função para validar uma transação. Regra de negócio: apenas vendedores podem validar transações.
    function validarTransacao(uint _idProduto, string memory _dataTransacao, uint _valorTransacao, uint _quantidade, bytes32 _fornecedor, bytes32 _comprador, TipoUsuario _tipoComprador) public {
        // Apenas vendedores podem validar transações.
        require(usuarios[msg.sender] == TipoUsuario.Vendedor, "Somente vendedores podem validar transacoes");
        // Itera sobre as transações e marca a transação correspondente como validada.
        for (uint i = 0; i < transacoes.length; i++) {
            if (
                transacoes[i].idProduto == _idProduto &&
                keccak256(bytes(transacoes[i].dataTransacao)) == keccak256(bytes(_dataTransacao)) &&
                transacoes[i].valorTransacao == _valorTransacao &&
                transacoes[i].quantidade == _quantidade &&
                transacoes[i].fornecedor == _fornecedor &&
                transacoes[i].comprador == _comprador &&
                transacoes[i].tipoComprador == _tipoComprador
            ) {
                transacoes[i].validada = true;
                emit NovaTransacaoRegistrada(_idProduto, _dataTransacao, _valorTransacao, _quantidade, _fornecedor, _comprador, _tipoComprador, true);
                break;
            }
        }
    }

    // Função para calcular o preço médio das transações validadas. Regra de negócio: qualquer usuário pode calcular o preço médio das transações validadas.
    function calcularPrecoMedio() external view returns (uint) {
        uint somaValores = 0; // Variável para armazenar a soma dos valores das transações.
        uint contador = 0; // Variável para contar o número de transações validadas.
        // Itera sobre as transações e inclui apenas as transações validadas no cálculo do preço médio.
        for (uint i = 0; i < transacoes.length; i++) {
            if (transacoes[i].validada) {
                somaValores += transacoes[i].valorTransacao;
                contador++;
            }
        }
        // Retorna zero se não houver transações validadas para evitar divisão por zero.
        if (contador == 0) {
            return 0;
        }
        // Retorna a média dos valores das transações validadas.
        return somaValores / contador;
    }

    //Função para remover um usuário do contrato. Regra de negócio: apenas o proprietário pode remover usuários.
    function removerUsuario(address _usuario) public {
        require(msg.sender == proprietario, "Somente o proprietario pode remover usuarios");
        delete usuarios[_usuario];
    }
}