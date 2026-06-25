*** Settings ***
Library  SeleniumLibrary


*** Variables ***
${account_number_locator}  xpath=//div[@id="openAccountResult"]/p/a
${account_type_dropdown}  id=type
${account_dropdown}  id=fromAccountId
${open_account_button}  //input[@value="Open New Account"]
${open_new_account_link}  xpath=//a[@href="openaccount.htm"]
${accounts_overview_link}  xpath=//a[@href="overview.htm"]
${transfer_funds_link}  xpath=//a[@href="transfer.htm"]
${log_out_link}  xpath=//a[@href="logout.htm"]
${registration_link}  xpath=//a[@href="register.htm"]

*** Keywords ***
Create a new account
    [Arguments]  ${type}  ${initial_account}
    Wait Until Page Contains Element    ${open_new_account_link}
    Click on new account link
    Select type of account    ${type}
    Select the account to transfer initial funds from    ${initial_account}
    Open new account
    ${account_number}=  Validate account creation
    Log    New savings account created: ${account_number}
    RETURN  ${account_number}

Click on new account link
    [Documentation]  This will click and open the page to create new account
    Click Element    ${open_new_account_link}

Select type of account
    [Arguments]  ${account_type}
    Wait Until Element Is Enabled    ${account_type_dropdown}
    Select From List By Label    ${account_type_dropdown}  ${account_type}

Select the account to transfer initial funds from
    [Arguments]  ${account_number}
    Wait Until Element Is Enabled    ${account_dropdown}
    ${accounts}=  Get List Items    ${account_dropdown}
    Log To Console    accounts:${accounts}
    Wait Until Keyword Succeeds    10s    1s    Select From List By Value    ${account_dropdown}  ${account_number}
    #flaky keyword select from list sometimes running sometimes not so using wait until keyword succeeds

Open new account
    Click Element    ${open_account_button}

Validate account creation
    Page Should Contain    Account Opened!
    Wait Until Element Is Visible    ${account_number_locator}
    ${new_account_number}=  Get Text    ${account_number_locator}
    RETURN  ${new_account_number}
