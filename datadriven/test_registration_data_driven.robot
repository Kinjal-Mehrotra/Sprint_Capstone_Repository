*** Settings ***
Resource  ../resources/keywords/common_keywords.robot
Resource  ../variables/registration_page_locators.robot
Resource  ../variables/home_page_locators.robot
Library    DataDriver   file=${EXECDIR}/test_data/registration_data.csv  dialect=excel

Test Setup    Run Keywords  Load Environment  Open Application
Test Teardown  Close Application
Test Template  User Registration


*** Test Cases ***
TC-DD-01 Data-Driven Registration (Multiple Credential Sets)   ${Firstname}    ${Lastname}    ${Address}    ${City}    ${State}    ${Zipcode}    ${Phno}    ${SSN}    ${Username}    ${Password}    ${Confirm}
   [Documentation]  Data driven testing using csv sheet
   [Tags]  Regression  UI  Datadriven

*** Keywords ***
User Registration
    [Arguments]  ${Firstname}    ${Lastname}    ${Address}    ${City}    ${State}    ${Zipcode}    ${Phno}    ${SSN}    ${Username}    ${Password}    ${Confirm}
    Click Element    ${registration_link}
    Input Text    ${first_name_field}    ${Firstname}
    Input Text    ${last_name_field}    ${Lastname}
    Input Text    ${address_field}    ${Address}
    Input Text    ${city_field}    ${City}
    Input Text    ${state_field}    ${State}
    Input Text    ${zip_code_field}    ${Zipcode}
    Input Text    ${phone_field}    ${Phno}
    Input Text    ${ssn_field}    ${SSN}
    Input Text    ${username_field}    ${Username}
    Input Text    ${password_field}  ${Password}
    Input Text    ${confirm_field}    ${Confirm}
    Click Element    ${register_button}