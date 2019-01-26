#!/bin/bash
#ProjectPronoxis Requirements checker

#!>>>>>>>>>                    >>>>>MAC PACKAGES<<<<<<<<<
function checker {
echo -e "\033[1;33m checking for Packges in your Mac \033[0m "   
  echo " "
    
    echo -e "\033[1;31m checking for HOMEBREW \033[0m"
    which brew &>/dev/null
    if [ $(echo $?) -eq "0" ]; then
      sleep 2
      echo -e "\033[1;32m                                                 [installed]\033[0m"
      sleep 1
    else
      echo -e "\033[1;31mInstalling HomeBrew. This may take several seconds.\033[0m"
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
      echo -e "\033[1;32m                                                 [installed]\033[0m"
    fi

#python
    echo -e "\033[1;31m checking for python \033[0m"
    which python &>/dev/null
    if [ $(echo $?) -eq "0" ]; then
      sleep 2
      echo -e "\033[1;32m                                                 [installed]\033[0m"
      sleep 1
    else
      echo -e "\033[1;31mInstalling Python using Homebrew. This may take several seconds.\033[0m"
      brew install python &>/dev/null & ./Progress.sh
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
      echo -e "\033[1;31mInstalling Nmap using Homebrew. This may take several seconds.\033[0m"
      brew install nmap &>/dev/null & ./Progress.sh
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
      echo -e "\033[1;31mInstalling Nikto using Homebrew. This may take several seconds.\033[0m"
      brew install nikto &>/dev/null & ./Progress.sh
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
      echo -e "\033[1;31mInstalling fping using Homebrew. This may take several seconds.\033[0m"
      brew install fping -y &>/dev/null & ./Progress.sh
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
      echo -e "\033[1;31mInstalling jq using Homebrew. This may take several seconds.\033[0m"
      brew install jq &>/dev/null & ./Progress.sh
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
      echo -e "\033[1;31mInstalling lynis using Homebrew. This may take several seconds.\033[0m"
      brew install lynis &>/dev/null & ./Progress.sh
      echo -e "\033[1;32m                                                 [installed]\033[0m"
    fi
#golismero
    echo -e "\033[1;31m checking for Golismero \033[0m"
    cd Golismero &>/dev/null
    if [ $(echo $?) -eq "0" ]; then
      sleep 2
      echo -e "\033[1;32m                                                 [installed]\033[0m"
      sleep 2
    else
      echo -e "\033[1;31mInstalling Golismero using Git. This may take several seconds.\033[0m"
      git clone https://github.com/golismero/golismero.git &>/dev/null & ./Progress.sh
      echo -e "\033[1;32m                                                 [installed]\033[0m"
    fi
}
clear
checker