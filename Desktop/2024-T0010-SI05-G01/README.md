# Inteli - Instituto de Tecnologia e Liderança 

<p align="center">
  <a href="https://www.inteli.edu.br/">
    <img src="./assets/imagens/inteli.png" alt="Inteli - Instituto de Tecnologia e Liderança" border="0" width="40%" height="40%">
  </a>
</p>


# Desenvolvimento de software com a utilização de blockchain

## ezTrack

## 🚀 Integrantes:

- <a href="https://www.linkedin.com/in/danielzular/">Daniel Zular</a>
- <a href="https://www.linkedin.com/in/davi-motta/">Davi Motta</a>
- <a href="https://www.linkedin.com/in/luizarsantana/">Luiza Santana</a>
- <a href="https://www.linkedin.com/in/mateus-mar%C3%A7al-212953264/">Mateus Marçal</a>
- <a href="https://www.linkedin.com/in/omatheusrsantos/">Matheus Ribeiro dos Santos</a>
- <a href="https://www.linkedin.com/in/stefano-parente-652822244/">Stefano Parente</a>

## 👩‍🏫 Professores:
### Orientador(a) 
- Renato Penha

### Instrutores
- Ana Cristina
- Fernando Pizzo
- Rafael Jacomossi
- Sergio Venancio
- Victor Hayashi

## 📜 Descrição

Um aplicativo que pode ser conectado ao SAP BTP (Business Technology Platform) e permita utilizar a blockchain para processos de cotação de
fornecedores, registrando o preço praticado das transações dos Compradores e Vendedores.

## 🎬 Video de Demonstração

<p> <a href="https://youtu.be/_8bUrUSXl-w?si=fa1OWTl0a44j_V-P">Este video </a> demonstra as principais funcionalidades da nossa aplicação, destacando sua usabilidade para os usuários.</p>

## 📁 Estrutura de pastas

|--> assets<br>
  &emsp;| --> imagens <br>
  &emsp;| --> videos <br>
  &emsp;|--> readme.md<br>
|--> docs<br>
  &emsp;| --> documentacao.md <br>
  &emsp;|--> readme.md<br>
|--> src<br>
  &emsp;|--> dapp-python<br>
  &emsp;|--> diagramas<br>
  &emsp;|--> eztrack-env<br> 
    &emsp;&emsp;|--> contratos<br> 
    &emsp;&emsp;|--> lib<br>  
    &emsp;&emsp;|--> script<br>
  &emsp;|--> frontend-web-cartesi<br>  
  &emsp;|--> readme.md<br>
| readme.md<br>

Dentre os arquivos e pastas presentes na raiz do projeto, definem-se:

- <b>assets</b>: aqui estão os arquivos relacionados a parte gráfica do projeto, ou seja, as imagens e links de vídeos que os representam (o logo do grupo pode ser adicionado nesta pasta).

- <b>docs</b>: aqui estão todos os documentos do projeto. Há também um arquivo README para o grupo registrar a localização de cada artefato.

- <b>src</b>: Todo o código fonte criado para o desenvolvimento do projeto, incluindo backend e frontend se aplicáveis.

- <b>README.md</b>: arquivo que serve como guia e explicação geral sobre o projeto (o mesmo que você está lendo agora).

## 🔧 Instalação

## Cartesi dApp


Um dApp da Cartesi é um aplicativo descentralizado (dApp) construído na plataforma Cartesi. Cartesi é uma plataforma de desenvolvimento de dApps que busca combinar a flexibilidade e a facilidade de uso dos sistemas operacionais tradicionais com a segurança e a descentralização das redes blockchain.

A principal característica que distingue os dApps da Cartesi é a capacidade de executar computação intensiva e processamento de dados complexos fora da blockchain, usando máquinas virtuais Linux. Isso é possível graças à integração da Cartesi com as infraestruturas de computação off-chain, onde a maioria das operações ocorre fora da cadeia, mas ainda é garantida pela segurança da blockchain.

Essa abordagem oferece várias vantagens, incluindo:

1. **Escalabilidade:** Ao mover a computação intensiva para fora da blockchain, os dApps da Cartesi podem escalar melhor, pois não são limitados pelas restrições de capacidade da própria blockchain.

2. **Flexibilidade:** Os desenvolvedores podem aproveitar a vasta gama de ferramentas e bibliotecas disponíveis para sistemas operacionais Linux, facilitando o desenvolvimento de dApps complexos.

3. **Eficiência de custos:** Como parte do processamento ocorre off-chain, os custos de execução do dApp podem ser reduzidos em comparação com aqueles que dependem exclusivamente de recursos on-chain.

### Configurando seu Ambiente de Desenvolvimento

Para desfrutar de uma experiência de desenvolvimento de dApps (aplicativos descentralizados) com Cartesi Rollups, você deve ter o Windows Subsystem for Linux 2 (WSL2) instalado e configurado corretamente.

Aqui estão os requisitos gerais:

#### WSL2 e Ubuntu
- WSL2 e Ubuntu devem estar instalados.

#### Python3
- Python3 deve estar instalado.

#### Node.js
- Node.js deve estar instalado.

#### Yarn
- Yarn deve estar instalado.

#### Sunodo
- Sunodo deve estar instalado.

#### Docker Desktop
- Docker Desktop deve estar instalado.

### Instalando WSL2 e Ubuntu

1. Abra a Microsoft Store e instale o WSL2.
2. Abra a Microsoft Store e instale a distribuição Ubuntu.

### Instalando e Configurando o Docker

1. Baixe e execute o instalador do Docker Desktop.
   - [Docker Desktop for Windows(Installer)](https://www.docker.com/products/docker-desktop)

### Instalando Node.js/NPM

1. Abra o terminal do Ubuntu (instalado anteriormente com o WSL).
2. Instale o nvm executando o seguinte comando:
   ```bash
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash

### Instalando e Configurando o Docker

1. **Ative o Terminal do Ubuntu**:
    - Abra o terminal do Ubuntu (instalado anteriormente com o WSL).

2. **Instalando Docker Desktop**:
    - Baixe e execute o instalador do Docker Desktop.
      - [Docker Desktop for Windows(Installer)](https://www.docker.com/products/docker-desktop)

### Instalando Node.js/NPM

1. **Ative o Terminal do Ubuntu**:
    - Abra o terminal do Ubuntu (instalado anteriormente com o WSL).

2. **Instalando nvm**:
    - Execute o seguinte comando para instalar o nvm:
      ```bash
      curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
      ```

3. **Ative o nvm**:
    - Ative o nvm em seu terminal com o comando:
      ```bash
      source ~/.bashrc
      ```

4. **Instalando a Versão Mais Recente do Node.js**:
    - Instale a versão mais recente do Node.js com o comando:
      ```bash
      nvm install node
      ```

5. **Defina a Versão Recém-Instalada como Padrão**:
    - Defina a versão recém-instalada como padrão com o comando:
      ```bash
      nvm alias default node
      ```

### Instalando Python

1. **Ative o Terminal do Ubuntu**:
    - Abra o terminal do Ubuntu (instalado anteriormente com o WSL).

2. **Instalando Python**:
    - Execute os seguintes comandos para instalar o Python:
      ```bash
      sudo apt update
      sudo apt install python3
      ```

### Instalando Yarn

1. **Ative o Terminal do Ubuntu**:
    - Abra o terminal do Ubuntu (instalado anteriormente com o WSL).

2. **Adicionando o Repositório APT do Yarn**:
    - Adicione o Repositório APT do Yarn com os seguintes comandos:
      ```bash
      sudo apt update
      sudo apt install curl
      curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
      echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
      ```

3. **Instalando Yarn**:
    - Instale o Yarn com os seguintes comandos:
      ```bash
      sudo apt update
      sudo apt install yarn
      ```

### Instalando Sunodo

- **Instale o Sunodo**:
    - Instale o Sunodo com o seguinte comando:
      ```bash
      npm install -g @sunodo/cli
      ```

### Nota Importante

Para garantir compatibilidade e desempenho ideais, o Docker Engine depende do WSL2 para sua operação. Portanto, inicie o WSL2 lançando o PowerShell e executando o comando "wsl" antes de iniciar o Docker Desktop.

Não execute mais comandos no PowerShell/terminal nativo do Windows. Tudo o mais será feito na distribuição Ubuntu que você instalou.

Para um fluxo de trabalho de desenvolvimento sem problemas, recomenda-se não executar comandos do Docker dentro do PowerShell ou do terminal WSL. Em vez disso, abra a distribuição Ubuntu que você instalou e execute todas as codificações e execuções de comando dentro desse ambiente Linux.

## **Descrição do Objetivo do Sistema** 
O sistema implementado tem como principal objetivo facilitar e automatizar transações descentralizadas entre usuários, seguindo os princípios da tecnologia blockchain. Ele foi desenvolvido para gerenciar transações de compra e venda de produtos, garantindo transparência, segurança e eficiência no processo. Além disso, busca oferecer funcionalidades para adicionar novos usuários, registrar transações, validar transações por parte dos envolvidos e calcular métricas importantes, como a média de preço de um produto. A aplicação visa fornecer um ambiente confiável e escalável para transações na web 3.0.

### **Estrutura do Sistema**
O sistema é composto por diversas partes interconectadas que trabalham em conjunto para garantir seu funcionamento adequado. Abaixo está a estrutura detalhada do sistema:

#### **1. Variáveis de Estado**

&emsp;- owner: endereço Ethereum do proprietário do sistema.
&emsp;- confirmed_transactions: lista de transações confirmadas.
&emsp;- not_confirmed_transactions: lista de transações não confirmadas.
&emsp;- users_list: lista de usuários registrados no sistema.

#### **2. Classe Transaction**
A classe Transaction é responsável por representar uma transação no sistema. Ela possui os seguintes atributos:

&emsp;- sender: endereço Ethereum do remetente.
&emsp;- receiver: endereço Ethereum do destinatário.
&emsp;- product_id: identificador do produto.
&emsp;- price: preço da transação.
&emsp;- timestamp: timestamp da transação.

#### **3. Funções** 

&emsp;**a. Manipulação de Solicitações HTTP**

&emsp;&emsp;- send_notice(notice: str): envia uma notificação via requisição POST.
&emsp;&emsp;- send_report(report: str): envia um relatório via requisição POST.
&emsp;&emsp;- send_post(endpoint, json_data): envia uma requisição POST para um determinado endpoint.

&emsp;**b. Manipuladores de Solicitações Recebidas**

&emsp;&emsp;- handle_advance(data): manipula solicitações de avanço de estado.
&emsp;&emsp;- handle_inspect(data): manipula solicitações de inspeção de estado.

#### **4. Endpoints**

&emsp;&emsp;- /notice: endpoint para receber notificações do sistema.
&emsp;&emsp;- /report: endpoint para receber relatórios do sistema.
&emsp;&emsp;- /finish: endpoint para finalizar o processamento de uma solicitação.

#### **5. Loop Principal**
O loop principal é responsável por processar solicitações continuamente, utilizando os manipuladores adequados de acordo com o tipo de solicitação recebida.

#### **Funcionalidades Principais**
O sistema oferece as seguintes funcionalidades principais:

- Registro de usuários.
- Registro de transações.
- Validação de transações por parte do player envolvido na transação.
- Cálculo da média de preço de um produto específico.
- Envio de notificações e relatórios sobre eventos relevantes no sistema a partir de requisições POST.
- Rastreamento e visualização de transações confirmadas e não confirmadas.

### **Conclusão** 

O sistema apresentado proporciona uma solução robusta e escalável para transações descentralizadas na web 3.0. Com funcionalidades bem definidas e uma estrutura organizada, ele é capaz de atender às necessidades dos usuários, garantindo a integridade e a eficiência das operações realizadas.

## 🗃 Histórico de lançamentos

* 0.1.0 - 18/02/2024
    * Sprint 1: entendimento do negócio.
* 0.2.0 - 03/03/2024
    * Sprint 2: desenvolvimento de smart contract.
* 0.3.0 - 17/03/2024
    * Sprint 3: Criação de um dApp integrado com o front-end.


## 📋 Licença/License
<img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/cc.svg?ref=chooser-v1"><img style="height:22px!important;margin-left:3px;vertical-align:text-bottom;" src="https://mirrors.creativecommons.org/presskit/icons/by.svg?ref=chooser-v1"><p xmlns:cc="http://creativecommons.org/ns#" xmlns:dct="http://purl.org/dc/terms/"><a property="dct:title" rel="cc:attributionURL" href="https://github.com/Inteli-College/2024-T0010-SI05-G01">ezTrack  <a> by </a> <a rel="cc:attributionURL dct:creator" property="cc:attributionName" href="https://github.com/InteliProjects/.github/blob/main/profile/README.md">Inteli, <a href="https://www.linkedin.com/in/danielzular/">Daniel Zular</a>, <a href="https://www.linkedin.com/in/davi-motta/">Davi Motta</a>,  <a href="https://www.linkedin.com/in/luizarsantana/">Luiza Santana</a>, <a href="https://www.linkedin.com/in/mateus-mar%C3%A7al-212953264/">Mateus Marçal</a>, <a href="https://www.linkedin.com/in/omatheusrsantos/">Matheus dos Santos</a>, <a href="https://www.linkedin.com/in/stefano-parente-652822244/">Stefano Parente</a> is licensed under <a href="http://creativecommons.org/licenses/by/4.0/?ref=chooser-v1" target="_blank" rel="license noopener noreferrer" style="display:inline-block;">Attribution 4.0 International</a>.</p>
 
 
