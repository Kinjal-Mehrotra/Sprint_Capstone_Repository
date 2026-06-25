*** Settings ***
Resource    ../../resources/keywords/api_keywords.robot

Suite Setup  Load Api Environment and Create Session

*** Test Cases ***
TC-API-05 Verify Account Fields and Data Types in API Response
    [Documentation]  Verifies that the account object returned by GET /accounts/{accountId} contains all required fields (id, customerId, type, balance) with their expected data types (int, string, decimal).
    [Tags]  Regression  API
#    ${response}=  Get method  /customers/${CUSTOMER_ID}/accounts
    ${response}=  Get customer accounts  ${CUSTOMER_ID}
    ${body}=  Set Variable    ${response.json()}
    Validate Status Code    ${response}    200

    Should Not Be Empty    ${body}
    FOR  ${account}  IN  @{body}
        ${id}=  Get From Dictionary    ${account}    id
        ${customer_id}=  Get From Dictionary    ${account}    customerId
        ${type}=  Get From Dictionary    ${account}    type
        ${balance}=  Get From Dictionary    ${account}    balance

        Should Be True    ${id}>0
        Should Be True    ${customer_id}>0
        Should Contain    ['CHECKING','SAVINGS','LOAN']    ${type}
        Should Be True    isinstance(${balance},(int,float))

    END