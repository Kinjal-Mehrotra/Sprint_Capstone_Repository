*** Settings ***
Resource  ../../resources/pages/transfer_funds_page.robot
Resource  ../../resources/keywords/common_keywords.robot
Resource  ../../resources/pages/login_page.robot
Resource  ../../resources/pages/open_new_account.robot

Suite Setup  Load Environment
Test Setup  Open Application
Test Teardown  Close Application

*** Test Cases ***
TC-UI-TF-01 Transfer Funds Successfully via UI
    [Documentation]  Verifies that a logged-in user can successfully transfer a valid amount between two different accounts via the Transfer Funds UI and receives a transfer confirmation message.
    [Tags]  Smoke  Regression  UI
    Log in to parabank    ${USER_NAME}    ${USER_PASS}

    ${Account1}=  Create a new account    CHECKING    ${ACCOUNT_NUMBER}
    ${Account2}=  Create a new account    SAVINGS    ${ACCOUNT_NUMBER}

    Transfer funds  100  ${Account1}  ${Account2}

    Page Should Contain    Transfer Complete!
    Validate transfer details

TC-UI-TF-03 Transfer with Invalid (Non-Numeric) Amount
    [Documentation]  Verifies that the Transfer Funds form rejects non-numeric input in the amount field and displays a validation error, preventing the transfer from being processed.
    [Tags]  Negative  Smoke  Regression
    Log in to parabank    ${USER_NAME}    ${USER_PASS}

    ${Account1}=  Create a new account    CHECKING    ${ACCOUNT_NUMBER}
    ${Account2}=  Create a new account    SAVINGS    ${ACCOUNT_NUMBER}

    Transfer funds    abc    ${Account1}    ${Account2}
    Page Should Contain    Error!

#
#TC-UI-TF-01 Transfer Funds Successfully via UI
#    [Documentation]  Verifies that a logged-in user can successfully transfer a valid amount between two different accounts via the Transfer Funds UI and receives a transfer confirmation message.
#    [Tags]  Smoke  Regression  UI
#    Log in to parabank    ${USER_NAME}    ${USER_PASS}
#
#    ${Account1}=  Create a new account    CHECKING    ${ACCOUNT_NUMBER}
#
#    ${Account2}=  Create a new account    SAVINGS    ${ACCOUNT_NUMBER}
#
#    Transfer funds    ${EMPTY}    ${Account1}    ${Account2}
#    Page Should Contain    Error
