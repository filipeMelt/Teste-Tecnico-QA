*** Settings ***
Documentation       Cenário de adição de itens no carrinho e de compra de um item
Resource            ../../resource/keywords/compra/compra.resource
Resource            ../../resource/utils/gherkin_ptbr.robot
Suite Setup    Start Session
Suite Teardown    Finish Session

*** Test Cases ***
Cenário 1: Adicionar Produto ao Carrinho 
  Dado que eu pesquiso por um produto
  Quando seleciono o tamanho e a cor e clico em "Add to Cart"
  Então o produto deve ser adicionado ao carrinho com sucesso

Cenário 2: Finalização de Compra 
  Dado que eu possuo um produto no carrinho
  Quando eu realizo a finalização da compra
  Então a mensagem de confirmação de compra deve ser exibida com sucesso