*** Settings ***
Resource    ../../resources/keywords/api_keywords.robot
Library  DebugLibrary
Suite Setup  Load Api Environment and Create Session

*** Test Cases ***
TC-API-02a Create Savings Account via API
    [Documentation]  Verifies that a new Savings account can be created via the POST /createAccount API endpoint and that the response contains HTTP 200 along with the newly generated savings account ID.
    [Tags]  Regression  API

    ${new_account_created}=  Create account and get id    ${CUSTOMER_ID}    1    ${BASE_ACCOUNT_NUMBER}
    Log To Console    ${new_account_created}

TC-API-02b Create Checking Account via API
    [Documentation]  Verifies that a new Checking account can be created via the POST /createAccount API endpoint and that the response contains HTTP 200 along with the newly generated checking account ID.
    [Tags]  Regression  API

    ${new_account_created}=  Create account and get id    ${CUSTOMER_ID}    0    ${BASE_ACCOUNT_NUMBER}
    Log To Console    ${new_account_created}

TC-API-02c Create Loan Account via API
    [Documentation]  Verifies that a new Loan account can be created via the POST /createAccount API endpoint and that the response contains HTTP 200 along with the newly generated loan account ID.
    [Tags]  Regression  API

    ${new_account_created}=  Create account and get id    ${CUSTOMER_ID}    0    ${BASE_ACCOUNT_NUMBER}
    Log To Console    ${new_account_created}
