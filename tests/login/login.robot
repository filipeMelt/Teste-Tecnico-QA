*** Settings ***

Documentation       Cenário de login
Resource            ../../resource/keywords/login/login.resource
Resource            ../../resource/utils/gherkin_ptbr.robot
Suite Setup    Start Session
Suite Teardown    Finish Session

*** Test Cases ***
Cenário 1: Login de usuário 
  Dado que eu acesso a tela de login
  Quando informo um Email e uma Senha válidos e clico em Sign In
  Então o login é realizado com sucesso