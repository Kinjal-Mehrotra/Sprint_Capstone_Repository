*** Settings ***
Resource    ../../resources/keywords/api_keywords.robot

Suite Setup  Load Api Environment and Create Session

*** Test Cases ***
TC-API-03 Retrieve Accounts List via API
    [Documentation]  Verifies that the GET /customers/{customerId}/accounts endpoint returns HTTP 200 and an array of account objects for a valid customer ID.
    [Tags]  Smoke  Regression  API

    ${response}=  Get customer accounts  ${CUSTOMER_ID}
    Validate Status Code    ${response}    200
    ${body}=  Set Variable    ${response.json()}

    Log To Console  Status Code: ${response.status_code}
    Log To Console    ${body}

    ${total_accounts}=  Get Length    ${body}
    Log To Console    Number of accounts: ${total_accounts}

TC-API-03-NEG Retrieve Accounts with Non-Existent Customer ID
    [Documentation]  Verifies that the GET /customers/{invalidId}/accounts endpoint returns an appropriate HTTP 4xx error or empty response when queried with a non-existent customer ID.
    [Tags]  Regression  API  Negative
    ${response}=  Get customer accounts    99999999
    Validate Status Code    ${response}    400
    Log To Console    Accounts don't exist

TC-API-04 Get Account by ID via API
    [Documentation]  Verifies that the GET /accounts/{accountId} endpoint returns HTTP 200 and the correct account object when queried with a valid account ID.
    [Tags]  Smoke  Regression  API
    ${body}=  Retrieve account by its number  ${BASE_ACCOUNT_NUMBER}
    Should Not Be Empty    ${body}
