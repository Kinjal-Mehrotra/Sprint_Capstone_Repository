*** Settings ***
Resource  ../../resources/pages/Transfer_Funds_Page.robot
Resource  ../../resources/keywords/common_keywords.robot
Resource  ../../resources/pages/Login_Page.robot
Resource  ../../resources/keywords/api_keywords.robot

Suite Setup  Run Keywords  Load Environment  AND  Load environment-API
Test Setup  Run Keywords  Open Application  AND  Create a Session
Test Teardown  Close Application

*** Test Cases ***
TC-E2E-02 Validate Balances via API After UI Transfer
    [Documentation]  Verifies end-to-end balance integrity by capturing source and destination account balances via API before and after performing a fund transfer through the UI, then confirming the debit and credit amounts are correctly reflected.
    [Tags]  Smoke  Regression  Integration  End_To_End

    ${Account1}=  Create account and get id    ${CUSTOMER_ID}    1    ${BASE_ACCOUNT_NUMBER}
    ${Account2}=  Create account and get id    ${CUSTOMER_ID}    1    ${BASE_ACCOUNT_NUMBER}

    Log in to parabank    ${USER_NAME}    ${USER_PASS}

    ${body1}=  Retrieve account by its number  ${Account1}
    ${amount_before_transfer_acc1}=  Get amount    ${body1}
    Log to console  Balance of Account 1 before transfer: ${amount_before_transfer_acc1}

    ${body2}=  Retrieve account by its number  ${Account2}
    ${amount_before_transfer_acc2}=  Get amount    ${body2}
    Log to console  Balance of Account 2 before transfer: ${amount_before_transfer_acc2}

    Transfer funds    ${amount_to_transfer}    ${Account1}    ${Account2}
    Validate transfer details

    ${body3}=  Retrieve account by its number  ${Account1}
    ${amount_after_transfer_acc1}=  Get amount    ${body3}
    Log to console  Balance of Account 1 after transfer: ${amount_after_transfer_acc1}

    ${body4}=  Retrieve account by its number  ${Account2}
    ${amount_after_transfer_acc2}=  Get amount    ${body4}
    Log to console  Balance of Account 2 after transfer: ${amount_after_transfer_acc2}

    ${final_account_1}=  Evaluate  float(${amount_before_transfer_acc1})-float(${amount_to_transfer})
    ${final_account_2}=  Evaluate  float(${amount_before_transfer_acc2})+float(${amount_to_transfer})

    Should Be Equal As Numbers    ${amount_after_transfer_acc1}   ${final_account_1}
    Should Be Equal As Numbers    ${amount_after_transfer_acc2}  ${final_account_2}








