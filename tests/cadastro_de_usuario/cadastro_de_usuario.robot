*** Settings ***

Documentation       Cenário de cadastro de usuario
Resource            ../../resource/keywords/cadastro_de_usuario/cadastro_de_usuario.resource
Resource            ../../resource/utils/gherkin_ptbr.robot
Suite Setup    Start Session
Suite Teardown    Finish Session

*** Test Cases ***
Cenário 1: Cadastro de usuário 
  Dado que eu clico em Create an Account
  Quando clico em Create an Account com formulario preenchido devidamente com os dados do usuário
  Então valido a mensagem Thank you for registering with Main Website Store.