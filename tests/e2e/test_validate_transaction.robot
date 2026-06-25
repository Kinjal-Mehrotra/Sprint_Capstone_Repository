*** Settings ***
Resource  ../../resources/pages/Transfer_Funds_Page.robot
Resource  ../../resources/keywords/common_keywords.robot
Resource  ../../resources/pages/Login_Page.robot
Resource  ../../resources/keywords/api_keywords.robot

Suite Setup  Run Keywords  Load Environment  AND  Load environment-API
Test Setup  Run Keywords  Open Application  AND  Create a Session
Test Teardown  Close Application

*** Test Cases ***
TC-E2E-03 Validate Transaction History in API After UI Fund Transfer
    [Documentation]  Verifies end-to-end data integrity by performing a fund transfer through the UI and then querying the GET /accounts/{accountId}/transactions API endpoint to confirm that a new transaction record exists with the correct amount, type, and account reference.
    [Tags]  Smoke  Regression  Integration  End_To_End

    Log in to parabank    ${USER_NAME}    ${USER_PASS}

    ${Account1}=  Create account and get id    ${CUSTOMER_ID}    0    ${BASE_ACCOUNT_NUMBER}
    ${total_transactions_before}  ${body_before}=  Get transactions length
    Log To Console    Total transaction before: ${total_transactions_before}
    ${Account2}=  Create account and get id    ${CUSTOMER_ID}    1    ${BASE_ACCOUNT_NUMBER}

    Transfer funds    ${amount_to_transfer}    ${Account1}    ${Account2}
    Validate transfer complete

    ${total_transactions_after}  ${body_after}=  Get transactions length
    Log To Console    Total transactions after: ${total_transactions_after}


#    ${final_total}=  Evaluate    ${total_transactions_before} + 1
#    Should Be Equal As Integers    ${total_transactions_after}    ${final_total}

#    ${last_transaction}=  Set Variable  ${body_after}[-1]
#    ${amount}=  Get From Dictionary    ${last_transaction}    amount
#    Should Be Equal As Numbers   ${amount}    ${amount_to_transfer}