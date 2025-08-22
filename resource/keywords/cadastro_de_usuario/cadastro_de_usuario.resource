*** Settings ***
Resource    ../../utils/base.robot


*** Variables ***

${insertFirstName_id}               id=firstname
${insertLastName_id}                id=lastname
${singUpForNewsletter_id}           id=is_subscribed
${email_id}                         id=email_address
${password_id}                      id=password
${confirmPassword_id}               id=password-confirmation
${buttonCreateAnAccount_xpath}      //*[@id="form-validate"]/div/div[1]/button/span
${createAnAccount_xpath}            //div[@class='panel header']//a[contains(@href, "/customer/account/create")]
${msg_sucesso}                      xpath=/html/body/div[2]/main/div[1]/div[2]/div/div/div

*** Keywords ***
eu clico em Create an Account
    Click    ${createAnAccount_xpath}

preencho personal information
      Fill Text    ${insertFirstName_id}    Alexandre
      Fill Text    ${insertLastName_id}    Almeida

clico sign up for newsletter
    Click    ${singUpForNewsletter_id}

preencho sign-in information
    Fill Text    ${email_id}    alexandremelt862@gmail.com
    Fill Text    ${password_id}    f7R2xQ9pL0zM
    Fill Text    ${confirmPassword_id}    f7R2xQ9pL0zM

clico no botao create an account
    Click    ${buttonCreateAnAccount_xpath} 

valido mensagem
    ${txt}=    Get Text    ${msg_sucesso}
    Should Contain    ${txt}    Thank you for registering with Main Website Store.

clico em Create an Account com formulario preenchido devidamente com os dados do usuário
    preencho personal information
    clico sign up for newsletter
    preencho sign-in information
    clico no botao create an account

valido a mensagem Thank you for registering with Main Website Store.
    valido mensagem