*** Settings ***

Resource    ../../resources/keywords/api_keywords.robot
Suite Setup  Load Api Environment and Create Session
Library    OperatingSystem

*** Test Cases ***
#TC-API-06 Get Transactions for Account via API
#    [Documentation]  Verifies that the account object returned by GET /accounts/{accountId} contains all required fields (id, customerId, type, balance) with their expected data types (int, string, decimal).
#    [Tags]  Regression  API
#    ${total_transactions}  ${body}=  Get transactions length
#    Log To Console    Total transactions of account ${BASE_ACCOUNT_NUMBER} : ${total_transactions}
#    Log To Console    Transactions: ${body}