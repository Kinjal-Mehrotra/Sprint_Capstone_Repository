*** Settings ***
Library  SeleniumLibrary
Library  ../../config/environment.py

*** Variables ***
${BROWSER}  chrome
${ENV}  qa
${ACCOUNT_NUMBER}  13344

*** Keywords ***
Load Environment
    Load Env  ${ENV}
    ${url}=  Get Env    baseurl
    ${user_name}=  Get Env    username
    ${user_passwd}=  Get Env    user_password
#    ${user_fullname}=  Get Env    user_fullname

    Set Suite Variable    ${BASE_URL}  ${url}
    Set Suite Variable    ${USER_NAME}  ${user_name}
#    Set Suite Variable    ${USER_FULLNAME}  ${user_fullname}
    Set Suite Variable    ${USER_PASS}  ${user_passwd}

Open Application
    [Documentation]  Opening the application
    Open Browser  ${BASE_URL}  ${BROWSER}
    Maximize Browser Window

Close Application
    [Documentation]  Closing the application
    Close All Browsers

Record Page Load Time
    ${load_time}=    Execute Javascript
    ...    return window.performance.timing.loadEventEnd - window.performance.timing.navigationStart

    Log To Console    ${load_time} ms
    Log    Page Load Time: ${load_time} ms