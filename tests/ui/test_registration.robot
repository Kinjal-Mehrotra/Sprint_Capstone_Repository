*** Settings ***
Resource  ../../resources/pages/registration_page.robot

Suite Setup  Load Environment
Test Setup  Open Application
Test Teardown  Close Application

*** Test Cases ***
TC-RG-UI-01 Registration of a new user via UI
    [Documentation]  Verifies that a new user can successfully register on ParaBank by filling in all required fields with valid data.
    [Tags]  Smoke  Regression  UI
    Click on register link
    Register new user    taylor    Swift    123 Main Street    Paris    France    123456    9876543210    88888888    taylorswift1111    1234    1234
    Wait Until Page Contains    Welcome
    Page Should Contain    Welcome

TC-RG-UI-02 Password mismatch while registration of a new user via UI
    [Documentation]  Verifies that the registration form rejects submission when password and confirm-password fields do not match.
    [Tags]  Negative  UI  Regression
    Click on register link
    Register new user    alex    prichett    123 main street    rome    italy    123456    9999999999    55555555    alex    123    456
    Page Should Contain    Passwords did not match

#TC-RG-UI-03 Registration of new user via UI when user already exists
#    [Documentation]
#    [Tags]  Negative
#    Click on register link
#    Register new user    abc    abc    xyz    xyz    cde    123123    9999999999    88888888    john    demo    demo
#    Page Should Contain    	This username already exists.

#Registration of new user via UI
#    [Documentation]
#    [Tags]  Negative
#    Click on register link
#    Register new user    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
#    Page Should Contain    required
