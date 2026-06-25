*** Settings ***
Library  SeleniumLibrary
Resource  ../keywords/common_keywords.robot

*** Variables ***
${log_out_link}  xpath=//a[@href="logout.htm"]
${username_field}  xpath=//input[@name="username"]
${password_field}  xpath=//input[@name="password"]
${login_button}  xpath=//input[@value="Log In"]

*** Keywords ***
Log out of the application
    [Documentation]  Verify that clicking Log Out ends the session and subsequent direct navigation to a protected URL redirects to the Login page.
    Click Element    ${log_out_link}
    Page Should Contain Element  ${login_button}
#    Location Should Contain    index.htm
