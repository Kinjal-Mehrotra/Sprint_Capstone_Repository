*** Settings ***
Resource  ../../resources/pages/open_new_account.robot
Resource  ../../resources/keywords/common_keywords.robot
Resource  ../../resources/pages/login_page.robot

Suite Setup  Load Environment
Test Setup  Open Application
Test Teardown  Close Application

*** Test Cases ***
TC-AC-UI-01 Create New Savings Account via UI
    [Documentation]  Verifies that a logged-in user can open a new Savings account via the UI by selecting the account type and source account, and that a success confirmation with the new account number is displayed.
    [Tags]  Smoke  Regression  UI
    Log in to parabank    ${USER_NAME}    ${USER_PASS}
    ${new_account_number}=  Create a new account    SAVINGS    ${ACCOUNT_NUMBER}
    Log To Console    New Account created with account number : ${new_account_number}

TC-AC-UI-02 Create New Checking Account via UI
    [Documentation]  This test case verifies that a logged-in user can open a new Checking account via the UI by selecting the account type and source account, and that a success confirmation with the new account number is displayed.
    [Tags]  Smoke  Regression  UI
    Log in to parabank    ${USER_NAME}    ${USER_PASS}
    ${new_account_number}=  Create a new account    CHECKING    ${ACCOUNT_NUMBER}
    Log To Console    New Account created with account number : ${new_account_number}