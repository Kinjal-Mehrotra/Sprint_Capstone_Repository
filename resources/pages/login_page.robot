*** Settings ***
Library  SeleniumLibrary
Resource  ../keywords/common_keywords.robot

*** Variables ***
${username_field}  xpath=//input[@name="username"]
${password_field}  xpath=//input[@name="password"]
${login_button}  xpath=//input[@value="Log In"]

*** Keywords ***
Log in to parabank
    [Arguments]  ${username_for_login}  ${password_for_login}
    [Documentation]  This logs in to the website
    Log  Writing the username
    Wait Until Element Is Visible    ${username_field}
    Input Text    ${username_field}    ${username_for_login}
    Log  Writing the password
    Wait Until Element Is Visible    ${password_field}
    Input Text    ${password_field}    ${password_for_login}
    Wait Until Element Is Enabled    ${login_button}
    Click Element    ${login_button}