*** Settings ***
Resource    ../../utils/base.robot
Resource    ../login/login.resource
Library    ../../../.venv/lib/python3.13/site-packages/robot/libraries/XML.py

*** Variables ***
${checkout_id}              id=checkout
${firstProduct_id}          id=product-item-info_888
${size_id}                  id=option-label-size-157-item-179
${color_id}                 id=option-label-color-93-item-49
${buttonAddToCart_css}      css=button[title="Add to Cart"]
${proceedToCheckout_css}    css=button.action.primary.checkout[title="Proceed to Checkout"]
${search_id}                id=search
${firstName_css}            css=input[name="firstname"]
${lastName_css}             css=input[name="lastname"]
${company_css}              css=input[name="company"]
${streetAddress_css}        css=input[name="street[0]"]
${country_css}              css=[name="country_id"]
${stateProvince_css}        css=[name="region_id"]
${city_css}                 css=input[name="city"]
${zipPostalCode_css}        css=input[name="postcode"]
${phoneNumber_css}          css=input[name="telephone"]
${addToCart}                css=div.message-success.success.message
${removeItem_xpath}         xpath=//a[@title='Remove item']
${cart_xpath}               xpath=//a[@class='action showcart']
${buttonOk_xpath}           xpath=/html/body/div[4]/aside[2]/div[2]/footer/button[2]
${buttonNext_css}           css=#shipping-method-buttons-container button[data-role="opc-continue"]
# ${buttonNext_xpath}         xpath=//*[@id="shipping-method-buttons-container"]/div/button/span
${buttonPlaceOrder_css}     css=button[title="Place Order"]
${message_css}              css=div.page-title-wrapper span.base[data-ui-id="page-title-wrapper"]
${address_block_css}        css=div.shipping-address-item.selected-item
${produto}                  Cronus Yoga Pant
${loadingMask_css}          css=.loading-mask
${progressShippingActive}   css=.opc-progress-bar-item._active[data-step="shipping"]
${loadingMask_css}        css=.loading-mask
${address_block_css}      css=div.shipping-address-item.selected-item
${shipping_form_inline}   css=form#co-shipping-form:visible
${shipping_form_modal}    css=.modal-popup._show form[data-role="form-popup"]:visible
${btn_new_address}        css=#checkout-step-shipping button.action.action-show-pop
*** Keywords ***

preencho o campo busca
    Fill Text    ${search_id}    ${produto}
    Press Keys    ${search_id}    Enter

Seleciono tamanho e cor
    Wait For Elements State    ${firstProduct_id}    visible    30s
    Wait For Elements State    ${firstProduct_id}    stable     5s
    Click    ${firstProduct_id}

    Wait For Elements State    ${size_id}    visible    30s
    Wait For Elements State    ${size_id}    stable     5s
    Click    ${size_id}

    Wait For Elements State    ${color_id}    visible    30s
    Wait For Elements State    ${color_id}    stable     5s
    Click    ${color_id}

clico no botao add to cart
    Wait For Elements State    ${buttonAddToCart_css}    enabled    30s
    Click                      ${buttonAddToCart_css}
    Wait For Elements State    ${cart_xpath}    visible    30s

clico no botao proceed to checkout
    Wait For Elements State    ${proceedToCheckout_css}    visible    30s
    Scroll To Element          ${proceedToCheckout_css}
    Click    ${proceedToCheckout_css}

clico no botao next
    Wait For Elements State    css=.loading-mask    hidden    30s
    Wait For Elements State    ${buttonNext_css}    visible    30s
    Wait For Elements State    ${buttonNext_css}    stable     5s
    Wait For Elements State    ${buttonNext_css}    enabled    10s
    Scroll To Element          ${buttonNext_css}
    Click    ${checkout_id}
    Click    ${buttonNext_css}

clico no botao place order
    Wait For Elements State    ${buttonPlaceOrder_css}    enabled    30s
    Click                      ${buttonPlaceOrder_css}

valido mensagem de adição no carrinho
    Wait For Elements State    ${addToCart}    visible    30s
    Wait For Elements State    ${addToCart}    stable     5s
    ${txt}=    Get Text        ${addToCart}
    Should Contain    ${txt}   You added Cronus Yoga Pant to your shopping cart.

visualizo produtos no carrinho
    Sleep    3
    Wait For Elements State    ${cart_xpath}    enabled    30s
    Click                      ${cart_xpath}

excluir produtos no carrinho
    Click    ${removeItem_xpath}
    Click    ${buttonOk_xpath}

preencher campo
    [Arguments]    ${locator}    ${valor}
    Clear Text    ${locator}
    Fill Text     ${locator}    ${valor}

preencho informações pessoais
    preencher campo    ${firstName_css}    Alexandre
    preencher campo    ${lastName_css}     Almeida
    preencher campo    ${company_css}      Teste

preencho endereco e telefone
    preencher campo    ${streetAddress_css}    Avenida Rondon Pacheco, 1000
    Select Options By    ${country_css}    label    Brazil
    Select Options By    ${stateProvince_css}    label    Minas Gerais
    preencher campo    ${city_css}    Uberlândia
    preencher campo    ${zipPostalCode_css}    38405-142
    preencher campo    ${phoneNumber_css}    34999999999
    Sleep    3

preencher formulario
    Wait For Elements State    ${loadingMask_css}    hidden    30s

    ${tem_endereco}=    Run Keyword And Return Status
    ...    Wait For Elements State    ${address_block_css}    visible    2s
    IF    ${tem_endereco}
        Log    Endereço já cadastrado no sistema.
        Return From Keyword
    END

    ${inline_visivel}=    Run Keyword And Return Status
    ...    Wait For Elements State    ${shipping_form_inline}    visible    2s
    IF    not ${inline_visivel}
        ${tem_botao}=    Run Keyword And Return Status
        ...    Wait For Elements State    ${btn_new_address}    visible    5s
        Run Keyword If    ${tem_botao}    Click    ${btn_new_address}
        Run Keyword If    ${tem_botao}    Wait For Elements State    ${shipping_form_modal}    visible    10s
    END

    ${form_inline}=    Run Keyword And Return Status    Wait For Elements State    ${shipping_form_inline}    visible    1s
    ${form_modal}=     Run Keyword And Return Status    Wait For Elements State    ${shipping_form_modal}    visible    1s
    Return From Keyword If    not ${form_inline} and not ${form_modal}

    preencho informações pessoais
    preencho endereco e telefone

eu pesquiso por um produto
    eu acesso a tela de login
    informo um Email e uma Senha válidos e clico em Sign In
    preencho o campo busca

seleciono o tamanho e a cor e clico em "Add to Cart"
    seleciono tamanho e cor
    clico no botao add to cart

o produto deve ser adicionado ao carrinho com sucesso
    valido mensagem de adição no carrinho
    visualizo produtos no carrinho
    excluir produtos no carrinho

Validar Compra
    Sleep    2
    Wait For Elements State    ${message_css}    visible    30s
    ${msg}=    Get Text        ${message_css}
    Should Contain             ${msg}    Thank you for your purchase!

eu possuo um produto no carrinho
    eu pesquiso por um produto
    seleciono o tamanho e a cor e clico em "Add to Cart"

eu realizo a finalização da compra
    visualizo produtos no carrinho
    clico no botao proceed to checkout
    preencher formulario
    clico no botao next
    clico no botao place order

a mensagem de confirmação de compra deve ser exibida com sucesso
    Validar Compra