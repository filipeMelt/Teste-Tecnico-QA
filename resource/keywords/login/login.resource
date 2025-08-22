*** Settings ***
Resource    ../../utils/base.robot

*** Variables ***
${email_id}                id=email
${pass_id}                 id=pass
${mensagem_id}             id=search
${signIn_xpath}            xpath=//div[@class='panel header']//a[contains(@href, "/customer/account/login/referer")]
${buttonSignIn}            xpath=//fieldset[@class="fieldset login"]//button//span[normalize-space(.)="Sign In"]
${mensagem_erro_xpath}     xpath=//*[@id="maincontent"]/div[2]/div[2]/div/div/div
${validaLogin}             body > div.page-wrapper > header > div.panel.wrapper > div > ul > li.greet.welcome > span
${email}                   alexandreteste@gmail.com
${pass}                    f7R2xQ9pL0zM

*** Keywords ***
preencho email e password
    Wait For Elements State    ${pass_id}    visible    30s
    Fill Text    ${email_id}    ${email}
    Fill Text    ${pass_id}    ${pass}

clico no botao sign in
    Wait For Elements State    ${buttonSignIn}    visible    30s
    Wait For Elements State    ${buttonSignIn}    stable     10s
    Click    ${buttonSignIn}
    Reload

valido login
    Wait For Elements State    ${validaLogin}    visible    30s
    Wait For Elements State    ${validaLogin}    stable     10s
    ${txt}=    Get Text    ${validaLogin}
    ${temErro}=    Run Keyword And Return Status    Get Text    ${mensagem_erro_xpath}
    IF    ${temErro}
        ${txtErro}=    Get Text    ${mensagem_erro_xpath}
        Log    "Erro encontrado: ${txtErro}"    WARN
        Run Keyword If    '${txtErro}'=='Incorrect CAPTCHA'    Fail    "Login falhou: ${txtErro}"
        Run Keyword If    '${txtErro}'=='The account sign-in was incorrect or your account is disabled temporarily. Please wait and try again later.'    Fail    "Login falhou: ${txtErro}"
    END
    ${count}=    Get Element Count    ${mensagem_id}
    Should Be True    ${count} > 0

eu acesso a tela de login
    Wait For Elements State    ${signIn_xpath}    visible    30s
    Wait For Elements State    ${signIn_xpath}    stable     10s
    Click    ${signIn_xpath}

informo um email e uma senha válidos e clico em "Sign In"
    preencho email e password
    clico no botao sign in

o login é realizado com sucesso
    valido login