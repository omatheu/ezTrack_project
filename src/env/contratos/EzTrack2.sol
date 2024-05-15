// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

contract ProcessoCotacao {
    uint256 transactionID; // Variável para rastrear o ID da transação

    address public proprietarioContrato; // Endereço do proprietário do contrato

    // Estrutura para representar uma transação
    struct Transacao {
        uint256 transactionID; // ID da transação
        address validador; // Endereço do validador
        uint256 idProduto; // ID do produto
        string dataTransacao; // Data da transação
        uint valorTransacao; // Valor total da transação
        uint valorUnitario; // Valor unitário do produto
        uint quantidadeTransacionada; // Quantidade transacionada
        string unidadeDeMedida; // Unidade de medida do produto
        bool transacaoValidada; // Indica se a transação foi validada
    }

    // Mapeamento para armazenar transações por ID
    mapping(uint256 => Transacao) private transacoes;

    // Mapeamento para armazenar permissões de usuários
    mapping(address => bool) public usuarios;

    // Evento emitido quando uma nova transação é registrada
    event NovaTransacaoRegistrada(address indexed validador, uint256 indexed idProduto, string dataTransacao, uint valorTransacao, uint valorUnitario, uint quantidadeTransacionada, string unidadeDeMedida, bool transacaoValidada); 

    // Evento emitido quando uma transação é confirmada
    event NovaTransacaoConfirmada(address cadastrador, address validador, uint256 idTransacao); 

    // Construtor do contrato
    constructor() {
        proprietarioContrato = msg.sender; // Define o endereço do proprietário do contrato
    }
    
    // Modificador para restringir o acesso apenas ao proprietário do contrato
    modifier onlyOwner() {
       require(msg.sender == proprietarioContrato, "Somente o proprietario do contrato pode realizar esta acao");
       _; // Continua a execução do código
    }

    // Modificador para restringir o acesso apenas a usuários autorizados
    modifier onlyUser() {
        require(usuarios[msg.sender], "Voce nao tem permissao para realizar esta acao");
        _; // Continua a execução do código
    }

    // Função para registrar um novo usuário
    function registrarUsuario(address _usuario) public onlyOwner {
        usuarios[_usuario] = true; // Define o usuário como autorizado
    }

    // Função para cadastrar uma nova transação
    function cadastrarTransacao(address _validador, uint256 _idProduto, string memory _dataTransacao, uint256 _valorTransacao, uint256 _valorUnitario, uint256 _quantidadeTransacionada, string memory _unidadeDeMedida) public onlyUser {
        transactionID++; // Incrementa o ID da transação
        // Cria uma nova transação
        Transacao memory novaTransacao = Transacao({
            transactionID: transactionID,
            validador: _validador,
            idProduto: _idProduto,
            dataTransacao: _dataTransacao,
            valorTransacao: _valorTransacao, 
            valorUnitario: _valorUnitario, 
            quantidadeTransacionada: _quantidadeTransacionada,
            unidadeDeMedida: _unidadeDeMedida,
            transacaoValidada: false
        });
        transacoes[transactionID] = novaTransacao; // Armazena a transação no mapeamento
        // Emite o evento de nova transação registrada
        emit NovaTransacaoRegistrada(_validador, _idProduto, _dataTransacao, _valorTransacao, _valorUnitario, _quantidadeTransacionada, _unidadeDeMedida, true);
    }

    // Função para validar uma transação
    function validarTransacao(uint256 _idTransacao) public onlyUser {
        require(transacoes[_idTransacao].validador == msg.sender, "Voce nao pode validar esta transacao.");
        transacoes[_idTransacao].transacaoValidada = true; // Marca a transação como validada
        // Emite o evento de nova transação confirmada
        emit NovaTransacaoConfirmada(msg.sender, transacoes[_idTransacao].validador, _idTransacao);
    } 

    // Função para remover um usuário
    function removerUsuario(address _usuario) public onlyOwner {
        delete usuarios[_usuario]; // Remove o usuário dos autorizados
    }
}
