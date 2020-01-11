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
        apt install $1
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
checkRoot
isInstalled metasploit-framework
isInstalled ca-certificates
isInstalled msmtp
isInstalled screen
