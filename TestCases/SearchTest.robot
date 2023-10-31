*** Settings ***
Library    SeleniumLibrary
Suite Teardown    Close All Browsers
Test Setup  OpenChrome


*** Variables ***
${URL}    https://www.echopark.com/
${BROWSER}    headlesschrome
${user_agent}    Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.50 Safari/537.36



*** Keywords ***
Open Chrome
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --log-level\=3
    Call Method    ${chrome_options}    add_argument    user-agent\=${user_agent}

    Create Webdriver    Chrome    options=${chrome_options}


*** Test Cases ***
Search Bar Test
    Go To    ${URL}
    
    Wait Until Page Contains element    id:searchbar    timeout=30
    Input Text    id:searchbar    BMW X5
    Press Keys    id:searchbar    ENTER

    Wait Until Page Contains element    id:divVehicleTiles    timeout=30
    ${element_count}=    Get Element Count    css:div.vehicle-card
    ${elements}=    Get WebElements    css:a.vehicle-card-heading

    IF    ${element_count} > 0   
        FOR    ${element}    IN    @{elements}
            ${element_text}=    Get Text    ${element}
            Should Contain    ${element_text}    BMW X5
        END
    END