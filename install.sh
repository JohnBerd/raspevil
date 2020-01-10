#!/bin/bash

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

configMsmtp() {
    file_path="$HOME/.msmtprc"
    echo -e ""
    if test -f $file_path ; then
        echo "Your email seems to already have been configured"
        while [[ $answer != 'y' ]] && [[ $answer != 'n' ]]
        do
            read -p "Do you want to override the configuration? (y/n): " answer
        done
    fi
    if [ "$answer" == "n" ]; then return; fi
    read -p 'Your e-mail: ' email
    read -p 'Your SMTP server (smtp.gmail.com for gmail): ' smtp
    read -sp 'Your password: ' password
    echo -e ""

    cp res/.msmtprc $HOME
    sed -i "s/host.*/host $smtp/g" $file_path
    sed -i "s/from.*/from $email/g" $file_path
    sed -i "s/user.*/user $email/g" $file_path
    sed -i "s/password.*/password $password/g" $file_path
    
    echo "If the configure is OK, you should receive a mail in less than a minute :)"
    echo "Hello! Your raspevil mail configuration is correctly done" | msmtp $email
}

USER_HOME=$(getent passwd $SUDO_USER | cut -d: -f6)

checkRoot
isInstalled metasploit-framework
isInstalled ca-certificates
isInstalled msmtp
isInstalled screen
configMsmtp
