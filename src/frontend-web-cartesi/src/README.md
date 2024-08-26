# Documentação do Front-End do ezTrack

Este documento oferece uma visão geral dos principais arquivos de código incluídos no repositório e suas finalidades dentro da aplicação.


## Principais Arquivos de Código

### `App.tsx` e `App2.tsx`
São os componentes principais do React na nossa aplicação, responsáveis por renderizar a interface do usuário e integrar outros componentes. Esses arquivos estabelecem o roteamento e gerenciamento de estado do aplicativo.

### `config.json`
Contém as configurações de rede para conectar o front-end às redes blockchain. Inclui URLs RPC e endereços de contratos inteligentes para várias redes como Ethereum Mainnet e testnets.

### `GraphQL.tsx`
Esse arquivo gerencia consultas e mutações GraphQL. Define como o front-end se comunica com nossos serviços backend, recuperando dados da blockchain e submetendo transações.

### `index.tsx`
Esse arquivo inicializa o aplicativo renderizando o componente raiz e configura os provedores de serviço.

### `Input.tsx`
Define um componente React que lida com entradas de usuários. Aqui os usuários inserem dados para transações, que são então processados pelos contratos inteligentes.

### `Inspect.tsx`
Um componente que fornece a funcionalidade para inspecionar detalhes da transação e estados dos smart contracts. É utilizado para fins de auditoria e verificação pelos usuários.

### `Notices.tsx`
Responsável por exibir notificações e alertas ao usuário. Lida com mensagens de sucesso e erro ao longo da interação do usuário com o aplicativo.

### `Reports.tsx`
Gera e exibe relatórios baseados em dados de transações. Este componente ajuda os usuários a analisar tendências e tomar decisões informadas.

### `Network.tsx`
Lida com a lógica de rede do aplicativo. Conecta-se à blockchain, gerencia instâncias web3 e garante que a interação do usuário esteja sincronizada com o estado da blockchain.

### `react-app-env.d.ts`
Definições de tipo TypeScript específicas para o ambiente create-react-app.

### `routes.tsx`
Define o roteamento para a aplicação.

### `style-page.css`
A folha de estilo principal da aplicação. Fornece a aparência geral do aplicativo, definindo estilos para layout, cores, tipografia e mais.

### `useRollups.tsx`
Um hook React personalizado que interage com rollups de blockchain. É projetado para operações em soluções de escalabilidade que agrupam múltiplas transações para melhor desempenho e menores custos.


## Nomenclatura de Variáveis, Funções e Principais Fluxos de Controle e de Comunicação


### `App.tsx`

#### Variáveis

- `config`: Carrega as configurações da aplicação a partir do arquivo `config.json`, que inclui informações de rede e contratos para a conexão com a blockchain.
- `injected`: Representa o módulo de carteiras injetadas, permitindo a integração com carteiras como MetaMask.
- `dappAddress`: Mantém o estado do endereço do contrato inteligente da aplicação, permitindo que o usuário interaja com diferentes contratos.

#### Funções e Hooks

- `useState`: Hook do React utilizado para criar o estado `dappAddress`, que pode ser atualizado pela função `setDappAddress`.
- `init`: Configura a biblioteca `@web3-onboard/react` para integração com as carteiras e blockchains definidas em `config`.

#### Componentes

- `BrowserRouter`: Componente do `react-router-dom` que envolve a aplicação, permitindo a navegação entre diferentes componentes.
- `Network`: Exibe e gerencia o estado da rede blockchain conectada.
- `GraphQLProvider`: Fornece um contexto para realizar consultas GraphQL dentro da aplicação.
- `Inspect`: Permite ao usuário inspecionar detalhes do contrato inteligente e estado da blockchain.
- `Input`: Captura entradas de dados do usuário e envia informações ao contrato inteligente.

#### Fluxo de Controle

- O usuário interage com o campo de entrada para modificar o 'dappAddress'.
- A modificação é passada ao componente 'Input'.
- Os componentes 'Network' e 'Inspect' facilitam as interações com a blockchain, estando todos contidos dentro do 'GraphQLProvider' para acesso a funcionalidades relacionadas a GraphQL.
- Ações do usuário são capturadas pelo estado e pelos componentes.
- A comunicação com a blockchain é feita através de chamadas de contrato inteligente e consultas GraphQL.
- A aplicação reage a mudanças de estado e atualiza a UI conforme necessário.


### `App2.tsx`

#### Componentes

Pagina

- **Tipo**: `FC` (Functional Component) do React.
- **Descrição**: Renderiza uma página simples com conteúdo estático.
- **Conteúdo JSX**: Composto por uma `div` que encapsula dois elementos `<h1>`, exibindo os textos "Outra pagina" e "TESTE".

#### Estrutura e Fluxo

- **Estrutura Estática**: O componente `Pagina` não interage com estados (`useState`) ou efeitos (`useEffect`), resultando em uma apresentação puramente estática.
- **Fluxo de Controle**: Não existem fluxos de controle complexos ou interações com o usuário, mantendo o componente simplificado e focado na exibição do conteúdo.


### `GraphQL.tsx`

#### Variáveis Importantes

- `config`: Carrega as configurações a partir do arquivo `config.json`, que inclui URLs das APIs GraphQL para diferentes blockchains.

#### Funções Principais

`useGraphQL`

- **Descrição**: Um hook customizado que cria uma instância do cliente URQL baseado na cadeia conectada.
- **Fluxo de Controle**:
  1. Utiliza `useSetChain` para obter a cadeia conectada atualmente.
  2. Verifica se existe uma URL configurada para a API GraphQL da cadeia conectada. Se não, retorna `null`.
  3. Cria e retorna uma instância do cliente URQL configurada para a URL específica da cadeia.

`GraphQLProvider`

- **Descrição**: Um componente que utiliza o hook `useGraphQL` para fornecer uma instância do cliente URQL aos componentes filhos via Contexto React.
- **Props**:
  - `children`: Componentes filhos que terão acesso ao cliente URQL.
- **Fluxo de Controle**:
  1. Invoca `useGraphQL` para obter um cliente URQL configurado.
  2. Se um cliente válido for retornado, ele é fornecido aos componentes filhos usando o componente `Provider` da URQL.
  3. Caso contrário, renderiza uma `div` vazia, indicando a ausência de uma conexão GraphQL configurada.

#### Fluxo de Comunicação

- O componente `GraphQLProvider` comunica-se com a API GraphQL correspondente à cadeia blockchain conectada, oferecendo aos componentes filhos a capacidade de realizar consultas e mutações GraphQL de forma transparente.


### `Input.tsx`

#### Variáveis e Estados

- `dappAddress`: Endereço do dApp com o qual o usuário está interagindo, passado como prop.
- `connectedWallet`: Estado que armazena a carteira conectada atual.
- `provider`: Instância do provedor Web3 obtida da carteira conectada.
- `input`, `hexInput`, `erc20Amount`, `erc20Token`, `erc721Id`, `erc721`, `etherAmount`, `erc1155`, `erc1155Id`, `erc1155Amount`, `erc1155Ids`, `erc1155Amounts`, `erc1155IdsStr`, `erc1155AmountsStr`: Estados utilizados para capturar e armazenar entradas do usuário relativas às operações realizadas.

#### Funções

- `sendAddress(str: string)`: Envia o endereço de um dApp via contrato inteligente.
- `addInput(str: string)`: Adiciona uma entrada de usuário ao contrato inteligente.
- `depositErc20ToPortal(token: string, amount: number)`: Deposita tokens ERC20 em um portal específico.
- `depositEtherToPortal(amount: number)`: Deposita Ether em um portal específico.
- `transferNftToPortal(contractAddress: string, nftid: number)`: Transfere um NFT ERC721 para um portal.
- `transferErc1155SingleToPortal(contractAddress: string, id: number, amount: number)`: Transfere um token ERC1155 para um portal.
- `transferErc1155BatchToPortal(contractAddress: string, ids: number[], amounts: number[])`: Transfere um lote de tokens ERC1155 para um portal.
- `AddTo1155Batch()`, `Clear1155Batch()`: Funções auxiliares para manipulação de lotes ERC1155.

#### Fluxos Principais

1. **Conexão da Carteira**: Inicializa com a verificação da carteira conectada e criação do provedor Web3.
2. **Interação com Smart Contracts**: Utiliza funções específicas para enviar dados, depositar tokens, e transferir NFTs utilizando contratos inteligentes e a infraestrutura de rollups.
3. **Entrada do Usuário**: Captura e processa as entradas do usuário para diversas operações blockchain, como enviar endereço de dApp, adicionar entradas, depositar tokens, e transferir NFTs.


### `Inspect.tsx`

#### Variáveis e Estados

- `config`: Contém as configurações carregadas do arquivo `config.json`, que inclui URLs de API para inspeção por cadeia de blockchain.
- `inspectData`: Armazena a entrada do usuário para a consulta de inspeção.
- `reports`: Armazena os relatórios recebidos da API após a inspeção.
- `metadata`: Armazena metadados adicionais recebidos como parte da resposta da inspeção.
- `hexData`: Booleano que indica se os dados de inspeção devem ser tratados como hexadecimais.
- `postData`: Booleano que determina se a solicitação para a API de inspeção deve ser feita usando o método POST.

#### Funções

`inspectCall(str: string)`

- **Propósito**: Envia uma solicitação de inspeção para a API configurada e atualiza os estados `reports` e `metadata` com a resposta.
- **Fluxo**:
  - Verifica se há uma cadeia conectada e se a URL da API de inspeção está configurada.
  - Converte os dados de entrada para o formato adequado se `hexData` estiver ativado.
  - Realiza a solicitação de inspeção para a API usando GET ou POST, conforme determinado por `postData`.
  - Atualiza os estados `reports` e `metadata` com os dados recebidos na resposta.

#### Fluxos Principais de Controle e Comunicação

1. **Entrada de Dados**: O usuário insere os dados para inspeção e seleciona as opções `Raw Hex` e/ou `POST` conforme necessário.
2. **Envio da Inspeção**: Ao clicar no botão "Send", a função `inspectCall` é acionada com os dados fornecidos.
3. **Processamento da Resposta**: A resposta da API de inspeção é processada. Os relatórios são armazenados em `reports` e os metadados em `metadata`.
4. **Exibição dos Resultados**: Os resultados da inspeção são exibidos na interface do usuário, incluindo relatórios e metadados relevantes.


### `Network.tsx`

#### Variáveis de Estado e Configuração

- `config`: Carrega as configurações de blockchain do arquivo `config.json`, usado para determinar cadeias suportadas.
- `wallet`: Armazena informações sobre a wallet conectada atualmente.
- `connecting`: Booleano que indica se uma tentativa de conexão com a wallet está em andamento.
- `chains`: Lista de cadeias blockchain disponíveis para conexão.
- `connectedChain`: Armazena a cadeia blockchain atualmente selecionada.
- `settingChain`: Booleano que indica se a mudança de cadeia está em processo.

#### Hooks Utilizados

- `useConnectWallet`: Permite conectar a uma wallet e gerenciar o estado de conexão.
- `useSetChain`: Facilita a seleção e troca de cadeias blockchain.

#### Funções

- `connect()`: Inicia o processo de conexão com uma wallet.
- `disconnect(wallet)`: Desconecta a wallet especificada.
- `setChain({ chainId })`: Muda a cadeia blockchain conectada para a especificada pelo `chainId`.

#### Fluxos Principais de Controle e Comunicação

1. **Conexão com a Wallet**:
   - Se nenhuma wallet estiver conectada, exibe um botão para iniciar a conexão.
   - Durante a tentativa de conexão, exibe o estado "connecting".
   - Após a conexão, possibilita a desconexão através de um botão específico.

2. **Seleção de Cadeia Blockchain**:
   - Se uma wallet estiver conectada, exibe um seletor de cadeias blockchain.
   - Permite ao usuário trocar a cadeia blockchain, atualizando a aplicação conforme a seleção.
   - Previne a seleção de cadeias sem suporte, alertando o usuário.


### `Notices.tsx`

#### Variáveis e Tipos

- `Notice`: Tipo que define a estrutura de uma notificação, incluindo id, index, input (que por sua vez inclui index e payload) e payload.
- `notices`: Array de `Notice`, derivado dos dados recebidos da consulta GraphQL, processado para ser exibido.

#### Hooks Utilizados

- `useNoticesQuery`: Hook gerado pelo GraphQL para executar a consulta que busca as notificações. Retorna um objeto `result` que contém os dados (`data`), estado de carregamento (`fetching`) e possíveis erros (`error`).

#### Funções e Componentes

`Notices: React.FC`

- **Funcionalidade**: Componente funcional que utiliza `useNoticesQuery` para obter e exibir notificações.
- **Fluxos de Controle**:
  - **Carregamento**: Exibe uma mensagem de carregamento enquanto os dados estão sendo recuperados.
  - **Erro**: Exibe uma mensagem de erro caso a consulta falhe.
  - **Dados Vazios**: Exibe uma mensagem indicando a ausência de notificações se não houver dados ou se a consulta não retornar notificações.
  - **Exibição de Dados**: Processa e exibe as notificações em uma tabela, incluindo índices de entrada e de notificação, além do payload.


### `Reports.tsx`

#### Variáveis e Tipos

- `Report`: Tipo que define a estrutura de um relatório, incluindo `id`, `index`, `input` (que contém `index` e `payload`), e `payload`.
- `reports`: Array de `Report`, contendo os relatórios processados para exibição.

#### Hooks e Consultas GraphQL

- `useReportsQuery`: Hook GraphQL usado para realizar a consulta de relatórios. Retorna `result`, que contém os dados (`data`), o estado de fetching (`fetching`) e erros (`error`).

#### Componente `Reports: React.FC`

Estados

- `data`: Armazena os dados dos relatórios recebidos pela consulta GraphQL.
- `fetching`: Indica se a consulta está em andamento.
- `error`: Armazena possíveis erros que ocorram durante a consulta.

Funções e Lógica de Processamento

- **Processamento de Relatórios**:
  - Cada relatório recebido é processado para tentar converter os payloads de `input` e `payload` de hexadecimal para UTF-8, marcando-os como "(hex)" em caso de falha na conversão.
  - Os relatórios são então ordenados por índice de `input` e `index` de relatório para organização na exibição.

#### Fluxos Principais de Controle

1. **Carregamento e Erros**:
   - Exibe uma mensagem "Loading..." durante a busca de dados.
   - Em caso de erro na consulta, mostra a mensagem de erro recebida.
   - Caso não haja dados ou relatórios, informa que não há relatórios disponíveis.

2. **Exibição de Relatórios**:
   - Uma vez recebidos e processados, os relatórios são exibidos em uma tabela que lista `Input Index`, `Notice Index` e `Payload` para cada relatório.

3. **Recarregar Dados**:
   - Um botão "Reload" permite ao usuário reexecutar a consulta GraphQL com política de requisição `network-only`, buscando os dados mais atualizados.


### `config.json`

#### Estrutura das Configurações

Cada rede blockchain é identificada por um identificador hexadecimal (por exemplo, `0x7a69`, `0xaa36a7`), e contém as seguintes configurações:

- `token`: O nome simbólico da criptomoeda da rede.
- `label`: O nome legível da rede, utilizado na interface do usuário.
- `rpcUrl`: URL do Provedor de Serviços RPC para interações com a blockchain.
- `graphqlAPIURL`: URL para a API GraphQL, usada para consultas de dados.
- `inspectAPIURL`: URL para a API de inspeção, utilizada para verificar estados e dados na blockchain.
- `DAppRelayAddress`: Endereço do contrato de Relay da DApp na rede.
- `InputBoxAddress`: Endereço do contrato de caixa de entrada para operações de dados.
- `EtherPortalAddress`: Endereço do contrato do portal Ether para depósitos e retiradas de Ether.
- `Erc20PortalAddress`: Endereço do contrato do portal ERC20 para manipulação de tokens ERC20.
- `Erc721PortalAddress`: Endereço do contrato do portal ERC721 para manipulação de tokens ERC721 (NFTs).
- `Erc1155SinglePortalAddress`: Endereço para o portal de token ERC1155 para operações de token único.
- `Erc1155BatchPortalAddress`: Endereço para o portal de token ERC1155 para operações em lote.

#### Uso das Configurações

As configurações são utilizadas pelo front-end da aplicação para:

- Estabelecer conexões com as blockchains através dos URLs RPC.
- Realizar consultas e buscar dados através das APIs GraphQL e de Inspeção.
- Interagir com contratos inteligentes específicos, como realizar depósitos ou retiradas de tokens, e operações com NFTs.


### `index.tsx`

#### Variáveis e Funções

- `container`: Referência ao elemento DOM onde o aplicativo React será montado. Utiliza `document.getElementById('root')` para localizar o elemento.
- `root`: A variável `root` é criada pela função `createRoot(container)`, responsável por iniciar a renderização do aplicativo React no contêiner especificado.
- `App`: Componente raiz do aplicativo React. É o ponto de entrada para a renderização da árvore de componentes do aplicativo.
- `reportWebVitals`: Função opcional utilizada para medir e reportar métricas de desempenho do aplicativo. Essas métricas podem ser enviadas para um endpoint de análise para monitoramento.

#### Fluxo Principal

1. **Seleção do Contêiner DOM**: A variável `container` é definida para referenciar o elemento DOM onde o aplicativo será montado.
2. **Criação da Raiz React**: Utilizando `createRoot` do pacote `react-dom/client`, a aplicação é inicializada no contêiner especificado.
3. **Renderização do Componente `App`**: O componente `App`, que representa o componente raiz do aplicativo, é renderizado dentro do contêiner DOM.
4. **Medição de Performance (Opcional)**: A função `reportWebVitals` é chamada para coletar e, opcionalmente, enviar métricas de desempenho do aplicativo para análise.


### `react-app-env.d.ts`

#### Variáveis Globais

- `window.ethereum`: Referência ao objeto Ethereum injetado pelo MetaMask. Permite a interação com a Ethereum blockchain, incluindo envio de transações, leitura de dados da blockchain e resposta a eventos.
- `window.web3`: Anteriormente usado como principal ponto de acesso às funcionalidades do Ethereum, agora está sendo substituído por `window.ethereum` em muitas aplicações.

#### Principais Fluxos de Controle e Comunicação

1. **Detecção de Wallet Ethereum**: O front-end verifica a existência de `window.ethereum` para determinar se o usuário tem uma wallet Ethereum compatível instalada.
2. **Solicitação de Conexão**: Se uma wallet Ethereum estiver presente, o aplicativo pode solicitar acesso à conta do usuário por meio de `window.ethereum.request({ method: 'eth_requestAccounts' })`.
3. **Envio e Recebimento de Transações**: Após a conexão, o aplicativo pode enviar transações usando `window.ethereum.request` e escutar eventos da blockchain para atualizações de dados relevantes.
4. **Compatibilidade com Web3**: Para aplicações que utilizam `window.web3`, é comum inicializar um objeto Web3 com `window.ethereum` como provedor para continuar usando a API Web3 junto com a nova API Ethereum.


### `reportWebVitals.ts`

#### Função `reportWebVitals`

A função `reportWebVitals` é uma função opcional que você pode passar para registrar qualquer resultado das métricas web vitais.

#### Uso

A função `reportWebVitals` é projetada para trabalhar com a biblioteca `web-vitals`, permitindo a fácil captura e relatório de métricas vitais da web como First Input Delay (FID), Largest Contentful Paint (LCP), e outras.

- **CLS** (Cumulative Layout Shift)
- **FID** (First Input Delay)
- **FCP** (First Contentful Paint)
- **LCP** (Largest Contentful Paint)
- **TTFB** (Time to First Byte)

#### Principais Fluxos de Controle

1. **Checagem do Callback**: A função primeiro verifica se o `onPerfEntry` é fornecido e é uma função.
2. **Importação Dinâmica**: Se o callback é válido, a função procede para importar dinamicamente a biblioteca `web-vitals`.
3. **Registro de Métricas**: Após a importação, a função registra o callback fornecido para cada uma das métricas web vitais mencionadas, permitindo que estas sejam monitoradas e reportadas conforme disponíveis.


### `routes.tsx`

#### Variáveis

- `routes`: Um array de objetos, onde cada objeto representa uma rota na aplicação com as seguintes propriedades:
  - `path`: A string que define o caminho da URL para a rota.
  - `element`: O componente React que será renderizado quando a rota é acessada.

#### Componentes Dinâmicos

Os componentes `App` e `App2` são associados às rotas `'/'` e `'/app2'`, respectivamente. Esses componentes são importados diretamente, mas o framework permite o uso de `lazy` para carregamento sob demanda.

#### Principais Fluxos de Controle

1. **Definição de Rotas**: As rotas são definidas no array `routes`, especificando o caminho e o componente correspondente.
2. **Renderização de Componentes**: Quando um usuário navega para um caminho específico, o componente associado à rota é renderizado.


### `style-page.css`

#### Variáveis de Estilo

A aplicação define variáveis globais para cores, facilitando a manutenção e consistência visual:

- `--background-color`: Cor de fundo principal da aplicação.
- `--button-color`: Cor de fundo dos botões ao passar o mouse.

#### Estilos Principais

Botão Centralizado

- **Classe `.Button-center`**: Define o estilo para botões centralizados na aplicação.
  - `display`: Flex para alinhamento e justificação do conteúdo.
  - `justify-content` e `align-items`: Centralizam o conteúdo vertical e horizontalmente.
  - `margin`, `padding`, `border-radius`: Espaçamento, preenchimento e bordas arredondadas.
  - `width` e `height`: Dimensões fixas.
  - `background-color`: Cor de fundo inicial branca.
  - `font-family`, `font-size`, `font-style`: Estilização do texto.
- **Pseudo-classe `:hover`**: Muda a cor de fundo do botão ao passar o mouse, utilizando a variável `--button-color`.

Configurações Gerais

- **Fonte Padrão**: Utilização da fonte 'Public Sans', importada do Google Fonts, aplicada ao corpo do documento e demais elementos.
- **Divisão de Login `.div--login`**:
  - `background-color`: Utiliza a variável de cor de fundo principal.
  - `display`: Flex para estruturar o layout.
  - `flex-direction`, `justify-content`, `align-items`: Organiza os elementos filhos verticalmente e os centraliza.
  - `height`, `padding`, `gap`: Altura total, preenchimento interno e espaço entre os elementos filhos.

#### Principais Fluxos de Estilização

- **Consistência Visual**: As variáveis de cores garantem um tema consistente e facilitam ajustes globais.
- **Interatividade**: A pseudo-classe `:hover` no botão centralizado adiciona uma camada de interatividade, melhorando a experiência do usuário.
- **Estrutura Flexível**: O uso de Flexbox na `.div--login` e no `.Button-center` oferece uma estrutura responsiva e adaptável a diferentes tamanhos de tela.


### `useRollups.tsx`

#### Variáveis e Funções Principais

Configuração

- `config`: Objeto contendo as configurações extraídas de um arquivo JSON. Inclui endereços dos contratos e URLs do RPC por cadeia de blockchain.

Hook `useRollups`

- `useRollups(dAddress: string)`: Hook personalizado para inicializar e retornar contratos Cartesi Rollups relevantes e um signer com base no endereço da DApp fornecido.

Estados e Efeitos

- Estados para manter os contratos inicializados e informações de cadeia/conexão da carteira.
- `useEffect`: Acompanha mudanças na carteira conectada e na cadeia para reconectar e reinicializar os contratos com base nas configurações de rede atuais.

Conexão e Configuração dos Contratos

- Dentro do `useEffect`, uma função `connect` é definida e chamada, responsável por criar instâncias dos contratos necessários para interagir com os Rollups da Cartesi, incluindo:
  - Contrato principal da DApp (`CartesiDApp`).
  - Contratos de porta de entrada para diferentes tipos de tokens e dados (`EtherPortal`, `ERC20Portal`, `ERC721Portal`, `ERC1155SinglePortal`, `ERC1155BatchPortal`).
  - Contratos para relé de endereço e caixa de entrada (`DAppAddressRelay`, `InputBox`).

#### Fluxos de Controle e Comunicação

- **Inicialização**: Ao carregar ou mudar a carteira/conexão, o hook verifica automaticamente as configurações atuais e reconecta os contratos necessários.
- **Flexibilidade e Configuração**: Adapta-se dinamicamente a diferentes redes blockchain, permitindo uma interação fácil com os contratos Cartesi Rollups em diversas cadeias.
- **Simplificação do Desenvolvimento**: Abstrai a complexidade de gerenciar conexões de contratos e estados, permitindo que os desenvolvedores se concentrem na lógica específica da aplicação.
