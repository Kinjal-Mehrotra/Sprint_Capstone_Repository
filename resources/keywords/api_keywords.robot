*** Settings ***
Library  RequestsLibrary
Library  Collections
Library  ../../config/environment.py

*** Variables ***
${API_alias}  parabank_session
${ENV}  qa
${CUSTOMER_ID}  12212
${BASE_ACCOUNT_NUMBER}  13344
${amount_to_transfer}  100

*** Keywords ***
Load Api Environment and Create Session
    Load environment-API
    Create a Session

Load environment-API
    Load Env  ${ENV}
    ${api_url}  Get Env    api_url
    ${username}  Get Env    username
    ${user_password}  Get Env    user_password

    Set Global Variable    ${API_URL}  ${api_url}
    Set Global Variable    ${USERNAME}  ${username}
    Set Global Variable    ${PASSWORD}  ${user_password}

Create a Session
    ${headers}=  Create Dictionary  Accept=application/json
    Create Session    ${API_alias}    ${API_URL}  headers=${headers}  verify=False

Validate Status Code
    [Arguments]  ${response}  ${expected_status_code}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status_code}

Get method
    [Arguments]  ${endpoint}
    Log To Console    ${API_alias}
    Log To Console    ${endpoint}
    ${response}=  GET On Session  ${API_alias}  ${endpoint}
    RETURN  ${response}

Post method
    [Arguments]  ${endpoint}  ${payload}
    ${response}=  POST On Session  ${API_alias}  ${endpoint}  params=${payload}
    RETURN  ${response}

Get customer accounts
    [Arguments]  ${CUSTOMER_ID}
    ${response}=  GET On Session  ${API_alias}  /customers/${CUSTOMER_ID}/accounts  expected_status=Any
    RETURN  ${response}

Create account and get id
    [Arguments]  ${customer_id}  ${account_type}  ${from_account}
    ${params}=  Create Dictionary
    ...  customerId=${customer_id}
    ...  newAccountType=${account_type}
    ...  fromAccountId=${from_account}

    ${response}=  Post method  /createAccount  ${params}
    Validate Status Code    ${response}    200
    ${body}=  Set Variable    ${response.json()}
    ${new_account_created}=  Get From Dictionary    ${body}    id
    Log    New account created id: ${new_account_created}
    RETURN  ${new_account_created}

Transfer the funds
    [Arguments]  ${from_account_id}  ${to_account_id}  ${amount}
    ${payload}=  Create Dictionary
    ...  fromAccountId=${from_account_id}
    ...  toAccountId=${to_account_id}
    ...  amount=${amount}

    ${response}=  Post method    /transfer    ${payload}
    RETURN  ${response}

Retrieve account by its number
    [Arguments]  ${account_number}
    ${response}=  Get method  /accounts/${account_number}
    ${body}=  Set Variable    ${response.json()}
    Log To Console    ${body}
    Validate Status Code    ${response}    200
    RETURN  ${body}

Get amount
    [Arguments]  ${response}
    ${amount}=  Get From Dictionary    ${response}    balance
    RETURN  ${amount}

Get transactions length
    ${response}=  Get method    /accounts/${BASE_ACCOUNT_NUMBER}/transactions
    Validate Status Code    ${response}    200
    ${body}=  Set Variable    ${response.json()}
    Log To Console    ${body}
    ${total_transactions}=  Get Length    ${body}

    RETURN  ${total_transactions}  ${body}

#Create account
#    [Arguments]  ${customer_id}  ${account_type}  ${from_account}
#
#    ${params}=  Create Dictionary
#    ...  customerId=${customer_id}
#    ...  newAccountType=${account_type}
#    ...  fromAccountId=${from_account}
#
#    ${response}=  Post method  /createAccount  ${params}
#
#    RETURN  ${response}



#Login and get customer ID
#    ${response}=  Get method  /login/${USERNAME}/${PASSWORD}
#    ${body}=  Set Variable    ${response.json()}
#    Validate Status Code    ${response}    200
#    Log To Console  Status Code: ${response.status_code}
#    Log To Console    ${body}
#    ${customer_id}=  Get From Dictionary    ${body}    id
#
#    Log    ${body} ${CUSTOMER_ID}
#
#    Set Suite Variable    ${CUSTOMER_ID}  ${customer_id}
#    Log To Console    Customer ID: ${CUSTOMER_ID}
#    RETURN  ${CUSTOMER_ID}

#Store response in body
#    [Arguments]  ${response}
#    ${body}=  Set Variable    ${response.json()}
#    RETURN  ${body}
