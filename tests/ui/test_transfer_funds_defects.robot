*** Settings ***
Resource  ../../resources/pages/transfer_funds_page.robot
Resource  ../../resources/keywords/common_keywords.robot
Resource  ../../resources/pages/login_page.robot
Resource  ../../resources/pages/open_new_account.robot

Suite Setup  Load Environment
Test Setup  Open Application
Test Teardown  Close Application

*** Test Cases ***
TC-UI-TF-02 Transfer with Insufficient Funds
    [Documentation]  Verifies that the system prevents a fund transfer and displays an appropriate error or warning when the entered transfer amount exceeds the available balance in the source account.
    [Tags]  Defect

    Log in to parabank    ${USER_NAME}    ${USER_PASS}
    ${Account1}=  Create a new account    CHECKING    ${ACCOUNT_NUMBER}

    ${Account2}=  Create a new account    SAVINGS    ${ACCOUNT_NUMBER}

    Transfer funds  10000000000000  ${Account1}  ${Account2}

    Page Should Not Contain    Transfer Complete!

TC-UI-TF-04 Transfer with Negative Amount
    [Documentation]  Verifies that the system rejects or gracefully handles a transfer request when a negative value is entered as the transfer amount.
    [Tags]  Defect

    Log in to parabank    ${USER_NAME}    ${USER_PASS}
    ${Account1}=  Create a new account    CHECKING    ${ACCOUNT_NUMBER}
    ${Account2}=  Create a new account    SAVINGS    ${ACCOUNT_NUMBER}

    Transfer funds  -1000000  ${Account1}  ${Account2}

    Page Should Not Contain    Transfer Complete!

TC-UI-TF-05 Transfer to Same Account
    [Documentation]  Verifies that the system prevents or appropriately handles a fund transfer where the source and destination accounts are the same.
    [Tags]  Defect

    Log in to parabank    ${USER_NAME}    ${USER_PASS}
    ${Account1}=  Create a new account    CHECKING    ${ACCOUNT_NUMBER}

    ${Account2}=  Create a new account    SAVINGS    ${ACCOUNT_NUMBER}

    Click on new transfer funds link

    Transfer funds  100  ${ACCOUNT_NUMBER}  ${ACCOUNT_NUMBER}

    Page Should Not Contain    Transfer Complete!

TC-UI-TF-06 Transfer Zero Amount
    [Documentation]  Verifies that the system rejects a transfer request where the entered amount is zero and displays a suitable validation error or warning.
    [Tags]  Defect

    Log in to parabank    ${USER_NAME}    ${USER_PASS}
    ${Account1}=  Create a new account    CHECKING    ${ACCOUNT_NUMBER}

    ${Account2}=  Create a new account    SAVINGS    ${ACCOUNT_NUMBER}
    Click on new transfer funds link

    Transfer funds  0  ${Account1}  ${Account2}

    Page Should Not Contain    Transfer Complete!