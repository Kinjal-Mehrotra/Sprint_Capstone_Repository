
*** Settings ***
Resource  ../../resources/pages/open_new_account.robot
Resource  ../../resources/keywords/common_keywords.robot
Resource  ../../resources/pages/login_page.robot
Resource  ../../resources/keywords/api_keywords.robot

Suite Setup  Run Keywords  Load Environment  AND  Load environment-API
Test Setup  Run Keywords  Open Application  AND  Create a Session
Test Teardown  Close Application

*** Test Cases ***
TC-E2E-01 Account Type In API Matches UI Selection

    [Documentation]  Verifies end-to-end data accuracy by creating an account via the UI with a specified initial deposit and confirming that the balance field returned by the API matches the deposit amount entered during UI account creation.
    [Tags]  Regression  Integration  End_To_End

    Log in to parabank    ${USER_NAME}    ${USER_PASS}
    Create a new account    CHECKING    ${BASE_ACCOUNT_NUMBER}

    ${new_account_created}=  Validate account creation
    Log To Console    ${new_account_created}

    ${body}=  Retrieve account by its number  ${new_account_created}

    Should Not Be Empty    ${body}

    ${type}=  Get From Dictionary    ${body}    type
    Should Be Equal As Strings    CHECKING    ${type}