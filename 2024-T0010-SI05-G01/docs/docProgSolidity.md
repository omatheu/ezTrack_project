## Descrição do objetivo do Smart Contract
&emsp;Este contrato tem como objetivo gerenciar transações de cotação entre vendedores e compradores, seguindo regras de negócio específicas. Além de oferecer funcionalidades para adicionar usuários e registrar transações de compra, o contrato também implementa a validação das transações por parte dos vendedores e o cálculo do preço médio das transações válidas. Para garantir transparência e segurança, apenas o proprietário do contrato tem permissão para remover usuários registrados. O contrato emite um evento sempre que uma nova transação é registrada, proporcionando uma forma de rastreamento das atividades. Adicionalmente, oferece a funcionalidade de mostrar todas as transações, permitindo que os participantes verifiquem o histórico completo de atividades no contrato. Essas características combinadas proporcionam um ambiente confiável e eficiente para facilitar o processo de compra e venda de produtos dentro do ambiente blockchain.


## Estrutura do Smart Contract 2.0

&emsp; O contrato implementado esta diretamente relacionado com as regras de negócio do sistema desenhado, como proposta da solução. O comportamento do smart contract, é definido mediante as variáveis de estado, eventos e funções de execução que complementam nosso código. Sendo assim, destacamos a funcionalidade e descrição de cada uma dessas propriedades dentro do nosso contrato:


1. **Variáveis**
      
      As Variáveis de Estado são usadas para armazenar dados que são mantidos entre chamadas de função e alterações de contrato. Eles são usados para criar um estado entre as alterações de contrato. Segue as variáveis do contrato:

      - **proprietarioContrato (address public)**: endereço do proprietário do contrato.
      - **usuarios (mapping)**: mapeamento que associa o endereço Ethereum de um usuário ao seu status na plataforma, ativo (true) ou inativo (false).
      - **transacoes (mapping)**: mapeamento que armazena os dados de uma transação (struct Transação) associando-os a um uint256 (posteriormente este uint se tornará o id da transação).

2. **Estrutura (struct)**
      - **Estrutura de Transação (struct)**: define uma estrutura de dados para representar cada transação, incluindo informações como ID da transação, endereço do validador, ID do produto, data da transação, valor total da transação, valor unitário do produto, quantidade, unidade de medida do produto e seus status (validada ou não).

3. **Evento** </br>
Os eventos servem para notificar a execução de algo no contrato, eles facilitam a comunicação e dinamismo na blockchain. Seguem os eventos  presentes no contrato:
      - **Evento NovaTransacaoRegistrada**: emitido quando uma nova transação é registrada no contrato.
       - **Evento NovaTransacaoConfirmada**: emitido quando uma nova transação é validada no contrato.

3. **Modificador** </br>
Um modifier é um recurso que permite encapsular lógica reutilizável para restringir ou modificar o comportamento de funções dentro de contratos inteligentes. Baixo estão os modifiers presentes no contrato:
      - **Modifier OnlyOwner**: restringe a execução da função pelo dono do contrato.
       - **Modifier OnlyUser**: restring a execução da função aos usuarios cadastrados.

4. **Construtor**
      - **Construtor**: atribui o endereço do proprietário como o endereço que fez o deploy do contrato.

5. **Funções**</br>
As Funções são usadas para executar operações e modificar o estado do contrato. Segue as funções presentes no contrato:
      - **Função registrarUsuario**: permite que o proprietário do contrato registre novos usuários, especificando seu endereço e tipo de usuário.
      - **Função cadastrarTransacao**: permite que os compradores cadastrem novas transações, adicionando informações sobre o produto, valor, quantidade e outros detalhes.
      - **Função validarTransacao**: permite que os vendedores validem transações, marcando-as como validadas.
      - **Função removerUsuario**: permite que o proprietário do contrato remova usuários registrados.

&emsp;Essas funcionalidades combinadas oferecem um ambiente transparente e seguro para facilitar transações de cotação entre vendedores e compradores na blockchain Ethereum.

## Aplicação e desenvolvimento do projeto em blockchain

&emsp;Os smart contracts são programas de computador que são executados em blockchain, uma espécie de registro digital descentralizado que permite o armazenamento e a transferência de informações de forma segura e confiável. Desta forma, os contratos são escritos em solidity (linguagem de programação) e são capazes de automatizar processos e garantir que as transações sejam executadas automaticamente e de acordo com regras pré-estabelecidas.

&emsp;Nos requisitos de negócios definidos pela empresa parceira do projeto, a Alliance, os smart contracts são aplicados no processo de cotação. Isso envolve automatizar o registro e a validação de transações entre vendedores e compradores, garantindo a transparência e a segurança das operações.

## Smart Contracts mais a fundo nas Regras de Negócio

&emsp;De acordo com a estruturação do nosso código, os smart contracts podem ser usados para gerenciar o processo de cotação, incluindo o registro de usuários, o cadastro de transações, a validação das transações pelos vendedores e o cálculo do preço médio das transações válidas. Isso simplifica e automatiza a administração do processo de cotação, reduzindo o risco de erros e fraudes.

&emsp;Além disso, os smart contracts verificam automaticamente as informações das transações, como o ID do produto, a data, o valor, a quantidade, o fornecedor e o comprador. Isso ajuda a garantir que as transações sejam executadas de acordo com as regras pré-definidas, proporcionando maior eficiência e segurança ao processo de cotação.
