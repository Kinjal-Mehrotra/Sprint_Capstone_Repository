*** Settings ***
Library  SeleniumLibrary
Resource  ../../resources/keywords/common_keywords.robot


*** Variables ***
${registration_link}  xpath=//a[@href="register.htm"]
${first_name_field}  id=customer.firstName
${last_name_field}  id=customer.lastName
${address_field}  id=customer.address.street
${city_field}  id=customer.address.city
${state_field}  id=customer.address.state
${zip_code_field}  id=customer.address.zipCode
${phone_field}  id=customer.phoneNumber
${ssn_field}  id=customer.ssn
${username_field}  id=customer.username
${password_field}  id=customer.password
${confirm_field}  id=repeatedPassword
${register_button}  xpath=//input[@value="Register"]

*** Keywords ***
Click on register link
    Click Element    ${registration_link}

Register new user
    [Arguments]  ${first_name}  ${last_name}  ${address}  ${city}  ${state}  ${zip_code}  ${phone}  ${ssn}  ${username}  ${password}  ${confirm_password}
    Input Text    ${first_name_field}    ${first_name}
    Input Text    ${last_name_field}    ${last_name}
    Input Text    ${address_field}    ${address}
    Input Text    ${city_field}    ${city}
    Input Text    ${state_field}    ${state}
    Input Text    ${zip_code_field}    ${zip_code}
    Input Text    ${phone_field}    ${phone}
    Input Text    ${ssn_field}    ${ssn}
    Input Text    ${username_field}    ${username}
    Input Text    ${password_field}  ${password}
    Input Text    ${confirm_field}    ${confirm_password}
    Click Element    ${register_button}

