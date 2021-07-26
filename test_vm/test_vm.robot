*** Settings ***
Library                SSHLibrary

*** Variables ***
${HOST}                127.0.0.1
${USERNAME}            waseem
${PASSWORD}            123123
${NET1}                inet 10.0.2.15
${NET2}                netmask 255.255.255.0
${NET3}                broadcast 10.0.2.255

*** Test Cases ***
Check Hostname
    ${HOSTNAME}=     Execute Command  hostname
    Log              ${HOSTNAME}
    Should Be Equal  ${HOSTNAME}  waseem-ahmad

Check Network
    ${NETWORK}=      Execute Command  ifconfig
    Log              ${NETWORK}
    Should Contain   ${NETWORK}  ${NET1}
    Should Contain   ${NETWORK}  ${NET2}
    Should Contain   ${NETWORK}  ${NET3}

Make Directory
    Execute Command         mkdir robot_control
    Directory Should Exist  robot_control

Make File
    Execute Command    touch file11.txt
    File Should Exist  file11.txt

Copy Directory To Virtual
    Put Directory    .\\dir1  .
    ${NUM_OF_FILES}  Execute Command   ls dir1 | wc -l
    Should Be Equal As Integers  ${NUM_OF_FILES}  3

Remove File From Virtual
    Execute Command  rm dir1/file2.txt
    ${NUM_OF_FILES}  Execute Command   ls dir1 | wc -l
    Should Be Equal As Integers  ${NUM_OF_FILES}  2

*** Keywords ***
Custom Setup
    Open Connection  ${HOST}  port=2222
    Login            username=${USERNAME}  password=${PASSWORD}

Custom TearDown
    close Connection
