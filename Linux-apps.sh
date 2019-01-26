#!/bin/bash
#ProjectPronoxis Requirements checker`
#Variables

#Functions
function UserChecker {

  if [ "$(whoami)" == "root" ]; then
    echo -e "\033[1;33mRoot Detected. Processing checks\033[0m"
    echo " "
    sleep 1
  else
    echo "\033[1;33mYou need Root Privileges to run this script\033[0m"
    echo "\033[1;33mPlease run ./Pronoxis.sh to make this script fully functional.\033[0m"
    exit

  fi

}

#USERCHECKER

function check_requirements {
  echo -e "\033[1;33m checking Packges \033[0m "   
  echo " "
    echo -e "\033[1;32m updating Linux  \033[0m"
    apt-get update &>/dev/null && apt-get upgrade &>/dev/null & ./Progress.sh
#python
    echo -e "\033[1;31m checking for python \033[0m"
    which python &>/dev/null
    if [ $(echo $?) -eq "0" ]; then
      sleep 2
      echo -e "\033[1;32m                                                 [installed]\033[0m"
      sleep 1
    else
      echo -e "\033[1;31mInstalling Python using apt-get. This may take several seconds.\033[0m"
      sudo apt-get install python -y &>/dev/null & ./Progress.sh
      echo -e "\033[1;32m                                                 [installed]\033[0m"
    fi
#nmap
    echo -e "\033[1;31m checking for Nmap \033[0m"
    which nmap &>/dev/null
    if [ $(echo $?) -eq "0" ]; then
      sleep 2
      echo -e "\033[1;32m                                                 [installed]\033[0m"
      sleep 1
    else
      echo -e "\033[1;31mInstalling Nmap using apt-get. This may take several seconds.\033[0m"
      sudo apt-get install nmap -y &>/dev/null & ./Progress.sh
      echo -e "\033[1;32m                                                 [installed]\033[0m"
    fi
#Nikto
    echo -e "\033[1;31m checking for Nikto \033[0m"
    which nikto &>/dev/null
    if [ $(echo $?) -eq "0" ]; then
      sleep 2
      echo -e "\033[1;32m                                                 [installed]\033[0m"
      sleep 1
    else
      echo -e "\033[1;31mInstalling Nikto using apt-get. This may take several seconds.\033[0m"
      sudo apt-get install nikto -y &>/dev/null & ./Progress.sh
      echo -e "\033[1;32m                                                 [installed]\033[0m"
    fi

#fping
    echo -e "\033[1;31m checking for fping \033[0m"
    which fping &>/dev/null
    if [ $(echo $?) -eq "0" ]; then
      sleep 2
      echo -e "\033[1;32m                                                 [installed]\033[0m"
      sleep 1
    else
      echo -e "\033[1;31mInstalling fping using apt-get. This may take several seconds.\033[0m"
      sudo apt-get install fping -y &>/dev/null & ./Progress.sh
      echo -e "\033[1;32m                                                 [installed]\033[0m"
    fi

#jq
    echo -e "\033[1;31m checking for jq \033[0m"
    which jq &>/dev/null
    if [ $(echo $?) -eq "0" ]; then
      sleep 2
      echo -e "\033[1;32m                                                 [installed]\033[0m"
      sleep 1
    else
      echo -e "\033[1;31mInstalling jq using apt-get. This may take several seconds.\033[0m"
      sudo apt-get install jq -y &>/dev/null & ./Progress.sh
      echo -e "\033[1;32m                                                 [installed]\033[0m"
    fi
#lynis 
    echo -e "\033[1;31m checking for lynis \033[0m"
    which lynis &>/dev/null
    if [ $(echo $?) -eq "0" ]; then
      sleep 2
      echo -e "\033[1;32m                                                 [installed]\033[0m"
      sleep 1
    else
      echo -e "\033[1;31mInstalling lynis using apt-get. This may take several seconds.\033[0m"
      sudo apt-get install lynis -y &>/dev/null & ./Progress.sh
      echo -e "\033[1;32m                                                 [installed]\033[0m"
    fi
#golismero
    echo -e "\033[1;31m checking for Golismero \033[0m"
    cd golismero &>/dev/null
    if [ $(echo $?) -eq "0" ]; then
      sleep 2
      echo -e "\033[1;32m                                                 [installed]\033[0m"
      sleep 1
    else
      echo -e "\033[1;31mInstalling Golismero using git. This may take several seconds.\033[0m"
      git clone https://github.com/golismero/golismero.git &>/dev/null & ./Progress.sh
      echo -e "\033[1;32m                                                 [installed]\033[0m"
    fi

}

clear
UserChecker
check_requirements