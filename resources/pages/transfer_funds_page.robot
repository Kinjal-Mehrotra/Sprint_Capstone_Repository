*** Settings ***
Library  SeleniumLibrary


*** Variables ***
${amount_field}  id=amount
${from_account_dropdown}  id=fromAccountId
${to_account_dropdown}    id=toAccountId
${transfer_button}  xpath=//input[@value="Transfer"]
${amount_transfered_confirm}  xpath=//div[@id="showResult"]/p/span
${from_account_confirm}  id=fromAccountIdResult
${to_account_confirm}  id=toAccountIdResult
${open_new_account_link}  xpath=//a[@href="openaccount.htm"]
${accounts_overview_link}  xpath=//a[@href="overview.htm"]
${transfer_funds_link}  xpath=//a[@href="transfer.htm"]
${log_out_link}  xpath=//a[@href="logout.htm"]
${registration_link}  xpath=//a[@href="register.htm"]

*** Keywords ***
Transfer funds
    [Arguments]  ${amount}  ${from_account}  ${to_account}
    Click on new transfer funds link
    Input the amount to be transferred  ${amount}
    Select the account to transfer funds from  ${from_account}
    Select the account to transfer funds to    ${to_account}
    Transfer funds button

Click on new transfer funds link
    [Documentation]  This will click and open the page to create new account
    Click Element    ${transfer_funds_link}

Input the amount to be transferred
    [Arguments]  ${amount}
    Set Test Variable    ${AMOUNT}  ${amount}
    Input Text    ${amount_field}    ${amount}

Select the account to transfer funds from
    [Arguments]  ${from_account_number}
    Set Test Variable    ${FROM_ACCOUNT_NUMBER}  ${from_account_number}
    Wait Until Element Is Enabled    ${from_account_dropdown}
    ${from_available_accounts}=  Get List Items    ${from_account_dropdown}
    Log To Console    accounts:${from_available_accounts}
    Wait Until Keyword Succeeds    10s    1s    Select From List By Value    ${from_account_dropdown}  ${from_account_number}

Select the account to transfer funds to
    [Arguments]  ${to_account_number}
    Set Test Variable    ${TO_ACCOUNT_NUMBER}  ${to_account_number}
    Wait Until Element Is Enabled    ${to_account_dropdown}
    ${to_available_accounts}=  Get List Items    ${to_account_dropdown}
    Log To Console    accounts:${to_available_accounts}
    Wait Until Keyword Succeeds    10s    1s    Select From List By Value    ${to_account_dropdown}  ${to_account_number}

Transfer funds button
    Click Element    ${transfer_button}

Validate transfer details
    Wait Until Page Contains Element    ${amount_transfered_confirm}
    Wait Until Page Contains  ${AMOUNT}
    Log To Console    ${AMOUNT}

    Page Should Contain    ${AMOUNT}
    Page Should Contain    ${FROM_ACCOUNT_NUMBER}
    Page Should Contain    ${TO_ACCOUNT_NUMBER}

Validate transfer complete
    Wait Until Page Contains Element    ${amount_transfered_confirm}  timeout=10s
    Page Should Contain    Transfer Complete!

Validate incomplete transfer
    Page Should Contain    Error!
