Automação de Testes – Projeto Teste Tecnico QA

Este repositório contém a automação de testes funcionais para o e-commerce https://magento2-demo.magebit.com, utilizando Robot Framework com a biblioteca Browser (Playwright).

Pré-requisitos:
Antes de rodar os testes, certifique-se de ter instalado:

- [Python 3.10+](https://www.python.org/downloads/)
- [pip](https://pip.pypa.io/en/stable/)
- [Node.js 18+](https://nodejs.org/en/) (necessário para o Browser/Playwright)
- [Robot Framework](https://robotframework.org/)

Instalação das dependências:

```bash
# Instalar biblioteca Browser + dependências
pip install robotframework-browser
rfbrowser init

# Instalar outras dependências listadas
pip install -r requirements.txt


Como executar os testes

1. Clonar o repositório
    git clone https://seu-repositorio.git
    cd Teste-Tecnico-QA

2. Ativar o ambiente virtual
    python -m venv .venv
    source .venv/bin/activate   # Linux/Mac
    .venv\Scripts\activate      # Windows

3. Executar todos os testes
    robot tests/

4. Executar uma suíte específica
    robot tests/login/login.robot
    robot tests/compra/compra.robot

5. Executar com tags
    robot -i smoke tests/
    robot -i regressao tests/

6. Relatórios gerados
    Após a execução, são criados na raiz do projeto:
     log.html → log detalhado da execução
     report.html → relatório consolidado
     output.xml → saída em XML