#!/bin/bash

header() {
    echo "$(tput setaf 2)
       .~~.   .~~.
      '. \ ' ' / .'$(tput setaf 1)
       .~ .~~~..~.
      : .\\ '~' /. :
     ~ (  \\   /  ) ~
    ( : '~'.~.'~' : )
     ~ .~ (   ) ~. ~
      (  : '~' :  ) $(tput sgr0)RaspEvil$(tput setaf 1)
       '~ .~~~. ~'
           '~'
    $(tput sgr0)"
}

isInstalled() {
    installed=$(dpkg -l $1 2> /dev/null)
    if [ "$installed" == "" ]
    then
        echo -e "\e[31m[ - ] $1 not yet installed\e[0m"
        sudo apt install $1
    else
        echo -e "\e[32m[ + ] $1 already installed\e[0m"
    fi
}

checkRoot() {
    if [ "$EUID" -ne 0 ]
    then echo -e "\e[31mPlease run as root\e[m"
        exit
    fi
}

clear
header
isInstalled metasploit-framework
isInstalled ca-certificates
isInstalled msmtp
isInstalled screen
mkdir -p ~/raspevil
mkdir -p ~/raspevil/backdoors
mkdir -p ~/raspevil/credentials
mkdir -p ~/raspevil/tmp
touch ~/raspevil/emails
touch ~/.msmtprc
