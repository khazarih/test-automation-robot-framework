*** Settings ***
Library    SeleniumLibrary
Test Setup  Open Echo Park Landing Page Using Chrome Browser
Suite Teardown    Close All Browsers


*** Variables ***
${URL}    https://www.echopark.com/
${BROWSER}    headlesschrome
${user_agent}    Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.50 Safari/537.36
${SEARCH_INPUT_FIELD}    id:searchbar


*** Keywords ***
Open Chrome
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver

    Call Method    ${chrome_options}    add_argument    --disable-extensions
    # Call Method    ${chrome_options}    add_argument    --headless
    # Call Method    ${chrome_options}    add_argument    --no-sandbox
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --log-level\=3
    Call Method    ${chrome_options}    add_argument    user-agent\=${user_agent}

    Create Webdriver    Chrome    options=${chrome_options}
    Maximize Browser Window

Open Echo Park Landing Page Using Chrome Browser
    Open Chrome
    Go To    ${URL}

An empty search input box
    Wait Until Element Is Visible         ${SEARCH_INPUT_FIELD}

I type keyword to search
    [Arguments]    ${keyword}
    Wait Until Page Contains element    ${SEARCH_INPUT_FIELD}    timeout=30
    Input Text    ${SEARCH_INPUT_FIELD}    ${keyword}
    Press Keys    ${SEARCH_INPUT_FIELD}    RETURN

Only results that contain this keyword is listed
    [Arguments]    ${keyword}
    Wait Until Page Contains element    id:divVehicleTiles    timeout=30
    ${element_count}=    Get Element Count    css:div.vehicle-card
    ${elements}=    Get WebElements    css:a.vehicle-card-heading

    IF    ${element_count} > 0   
        FOR    ${element}    IN    @{elements}
            ${element_text}=    Get Text    ${element}
            Should Contain    ${element_text}    ${keyword}
        END
    END

*** Test Cases ***
Search Bar Test
    GIVEN An empty search input box
    WHEN I type keyword to search    BMW X5
    Then Only results that contain this keyword is listed    BMW X5