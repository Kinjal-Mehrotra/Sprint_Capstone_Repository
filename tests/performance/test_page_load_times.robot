*** Settings ***
Library  SeleniumLibrary
Resource  ../../variables/home_page_locators.robot
Resource  ../../resources/pages/Open_New_Account.robot
Resource  ../../resources/pages/Transfer_Funds_Page.robot
Resource  ../../resources/pages/Login_Page.robot
Resource  ../../resources/keywords/common_keywords.robot

Suite Setup  Load Environment
Test Setup  Open Application
Test Teardown  Close Application

*** Variables ***
${find_transactions_link}  xpath=//a[@href="findtrans.htm"]

*** Test Cases ***
TC-PERF-UI-01 Capture page load times - create account page
    [Documentation]  Verifies that the Create Account and Transfer Funds UI pages fully load and all interactive elements are ready within 3 seconds.
    [Tags]  Regression  UI  Performance
    Log in to parabank    ${USER_NAME}    ${USER_PASS}
    Click on new account link
    Log To Console    Page load time of new account:
    Record Page Load Time

    Click on new transfer funds link
    Log To Console    Page load time of transfer funds:
    Record Page Load Time

    Click Element    ${find_transactions_link}
    Log To Console    Page load time of transactions page:
    Record Page Load Time
