*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}    https://www.echopark.com/
${BROWSER}    Chrome
${BROWSER_DRIVER}    /usr/local/bin/chromedriver


*** Test Cases ***
SearchTest
    ${chrome_options}=  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Open Browser    ${URL}    ${BROWSER}    options=${chrome_options}      executable_path=${BROWSER_DRIVER}
    Execute Javascript    console.log(1)
    Sleep    3
    Capture Page Screenshot
    # Wait Until Element Is Visible    id:searchbar
    # Input Text    id:searchbar    BMW X5