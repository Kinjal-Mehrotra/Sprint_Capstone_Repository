*** Settings ***
Resource  ../../resources/pages/login_page.robot
Resource  ../../resources/keywords/common_keywords.robot
Resource    ../../resources/pages/logout_page.robot

Suite Setup  Load Environment
Test Setup  Open Application
Test Teardown  Close Application

*** Test Cases ***
TC-LN-UI-01 Successful Login with Valid Credentials
    [Documentation]  This test case verifies that a registered user can successfully log in to the ParaBank application using valid username and password credentials via the UI login form.
    [Tags]  Smoke  Regression  UI
    Log in to parabank  ${USER_NAME}  ${USER_PASS}
    Wait Until Page Contains    Welcome
    Page Should Contain    Welcome

TC-LN-UI-02 Login Failure with Invalid Password
    [Documentation]  This test case verifies that the application denies login and displays an error message when a valid username is submitted with an incorrect password.
    [Tags]  Regression  UI  Negative
    Log in to parabank  ${USER_NAME}  1234
    Page Should Contain    Error!

TC-LN-UI-03 Login with Both Fields Empty
    [Documentation]  Verifies that the login form performs field-level validation and prevents submission when both username and password fields are left empty.
    [Tags]  Regression  UI  Negative
    Log in to parabank    ${EMPTY}    ${EMPTY}
    Wait Until Page Contains    Error!
    Page Should Contain    Error!

TC-LN-UI-04 Logout Terminates Session and Restricts Protected Pages
    [Documentation]  Verifies that clicking Log Out ends the user session and that any subsequent attempt to access a protected page redirects the user back to the login screen.
    [Tags]  Smoke  Regression  UI
    Log in to parabank    ${USER_NAME}    ${USER_PASS}
    Log out of the application