*** Settings ***
Documentation     A resource file with reusable keywords and variables.
Library         Collections
Library         RequestsLibrary
Library         OperatingSystem
Library         JSONLibrary
Library         String
Library         SeleniumLibrary
Library         OperatingSystem

*** Variables ***
${Base_URL}       http://localhost:8080
${body}           Set Global Variable  # Global variables for storing the request body and input values.
${input}          Set Global Variable

*** Keywords ***
Devowelizer Suite Setup
    [Documentation]  Suite set up
    set log level  INFO
    log  Test Suite Starts

Service API URL is available
    Log To Console     The URL is:  ${Base_URL}

User makes devowelizer Service API with vowel input and validate output
    Log To Console    User makes devowelizer Service API with vowel input and validate output
    # Set input variable to hello
    ${input}=    Set Variable    hello
    # Expected output after removing vowels
    ${expected}=   Set Variable    hll
    # Send the request and validate the output.
    ${body}=     Get request with input and validate output    ${input}    ${expected}
    RETURN    ${body}
    Log To Console    Devowelizer Test with Input Vowels

User makes devowelizer Service API with empty string input and validate output
    Log To Console    User makes devowelizer Service API with empty string input and validate output
    # Set input variable to an empty string
    ${input}=   Set Variable    ""
    ${expected}=   Set Variable    ""
    ${body}=   Get request with input and validate output    ${input}    ${expected}
    RETURN    ${body}
    Log To Console    Devowelizer Test with empty string input

User makes devowelizer Service API with input without vowels and validate output
    Log To Console    User makes devowelizer Service API with input without vowels and validate output
    # Set input variable to no vowel input string
    ${input}=   Set Variable    bdcfgh
    ${expected}=   Set Variable    bdcfgh
    ${body}=   Get request with input and validate output    ${input}    ${expected}
    RETURN    ${body}
    Log To Console    Devowelizer Test with input without vowels
    
Get request with input and validate output
    [Arguments]     ${input}     ${expected}
    # Create session
    Create session    MySession   ${Base_URL}
    log to console    The API service URL is ${Base_URL}/${input}
    # Send a GET request to the API
    ${response} =      GET On Session    MySession    ${Base_URL}/${input}
     # Convert the response status code and content to strings.
    ${status_code} =     convert to string    ${response.status_code}
    ${content}=     convert to string     ${response.content}
    # Store the response content in a variable.
    set test variable    ${body}      ${content}
    # Validate the status code and response content.
    Should Be Equal   ${status_code}    200
    Should Be Equal    ${body}    ${expected}
    log to console    Response_StatusCode is ${status_code} is Validated
    log to console    Response_Content is ${body} is Validated
    RETURN    ${body}

API response should have no vowels
    [Arguments]    ${body}
    @{output}=    Convert To List    ${body}
    @{vow}=    Create List    a    e    i    o    u
    FOR  ${char}    IN    @{output}
     # Ensure no vowels are present in the response.
        Should Not Contain    ${vow}    ${char}
    END
    log to console    URL after Devowelizer service is ${Base_URL}/${input}

Devowelizer Suite Teardown
     log  Test Suite Ends