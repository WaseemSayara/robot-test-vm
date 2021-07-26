*** Settings ***
Library                SSHLibrary
Suite Setup            Custom Setup
Suite Teardown         Custom Teardown

*** Variables ***
${HOST}                127.0.0.1
${USERNAME}            waseem
${PASSWORD}            123123


*** Keywords ***
Custom Setup
    Open Connection  ${HOST}  port=2222
    Login            username=${USERNAME}  password=${PASSWORD}

Custom TearDown
    close Connection
