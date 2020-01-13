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

clear
header
isInstalled metasploit-framework
isInstalled ca-certificates
isInstalled msmtp
isInstalled screen
isInstalled snapd
isInstalledSnap ngrok
touch ~/.msmtprc
cp -r raspevil-config ~/raspevil
cp -r .msf4 ~
sudo cp res/* /usr/local/bin
