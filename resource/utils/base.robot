*** Settings ***

Library        Browser

*** Variables ***
${base}    https://magento2-demo.magebit.com

*** Keywords ***
Start Session
    New Browser    browser=chromium    headless=False    args=["--start-maximized"]
    New Context    viewport=None    locale=en-US
    Set Browser Timeout    45s
    New Page       ${base}     wait_until=domcontentloaded
    Wait For Elements State    css=header.page-header    visible    30s
    Run Keyword And Ignore Error    Wait For Elements State    css=.loading-mask    hidden    30s

Finish Session
    Close Browser