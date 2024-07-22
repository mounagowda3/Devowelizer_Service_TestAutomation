*** Settings ***
Documentation  This is a testsuite for Devowelizer Service API Tests

Resource        ../../resources/Devowelizer_Resource/Devowelizer_Keywords.robot

Suite Setup       Devowelizer Suite Setup
Suite Teardown    Devowelizer Suite Teardown

*** Test Cases ***

Devowelizer Test with Input Vowels
    [Documentation]     Verify Devowelizer Service API with vowel input and Validate the output
        Given Service API URL is available
        ${body}=  When User makes devowelizer Service API with vowel input and validate output
        Then API response should have no vowels   ${body}

Devowelizer Test with Empty String
    [Documentation]     Verify Devowelizer Service API with empty string input and Validate the output
        Given Service API URL is available
        ${body}=  When User makes devowelizer Service API with empty string input and validate output
        Then API response should have no vowels    ${body}

Devowelizer Test with No Input Vowels
    [Documentation]     Verify Devowelizer Service API with input without vowels and Validate the output
        Given Service API URL is available
        ${body}=  When User makes devowelizer Service API with input without vowels and validate output
        Then API response should have no vowels    ${body}



