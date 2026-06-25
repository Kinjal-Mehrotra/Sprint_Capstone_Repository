*** Settings ***
Resource    ../../resources/keywords/api_keywords.robot

Suite Setup  Load Api Environment and Create Session

Library    OperatingSystem

*** Test Cases ***
TC-API-01 Login via api
    [Documentation]  This test case verifies whether user is able to successfully login via valid credentials using API
    [Tags]  Smoke  Regression  API

    ${response}=  Get method  /login/${USERNAME}/${PASSWORD}
    Validate Status Code    ${response}    200
    ${body}=  Set Variable    ${response.json()}

    Log To Console  Status Code: ${response.status_code}
    Log To Console    ${body}