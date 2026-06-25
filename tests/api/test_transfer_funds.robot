*** Settings ***

Resource    ../../resources/keywords/api_keywords.robot
Suite Setup  Load Api Environment and Create Session
Library    OperatingSystem

*** Test Cases ***
TC-API-06 Transfer funds via API
    [Documentation]  Verifies that funds can be transferred between two accounts via the POST /transfer API endpoint and that the response returns HTTP 200 with a transfer confirmation.
    [Tags]  Smoke  Regression  API

    ${Account1}=  Create account and get id    ${CUSTOMER_ID}    1    ${BASE_ACCOUNT_NUMBER}

    ${Account2}=  Create account and get id    ${CUSTOMER_ID}    1    ${BASE_ACCOUNT_NUMBER}

    ${response}=  Transfer the funds    ${Account1}   ${Account2}    10000

    Validate Status Code    ${response}    200