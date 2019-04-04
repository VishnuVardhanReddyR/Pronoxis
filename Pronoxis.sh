#!/bin/bash
#                                       ------------------PROJECT OF PRONOXIS----------------                                   
#Pronoxis Primary shell.
#Requirements     :Install PYTHON and COMMAND LINE TOOLS for MAC.
#title            :pronoxis.sh
#description      :This script will make you to Scan a server that you own or others own Easily.
#author		 	  :Vi5hnu
#date             :18/01/2019
#version          :1    
#usage		 	  :bash pronoxis.sh
#notes            :There is no much work for you,Everything is done with your little co-operation.
#External tools   :I used Nmap,Nikto,fping,jq,Golismero,lynis.
#bash_version     :4.4.23(1)-release
#Operating system :Pronoxis was Developed for both MACOS X and LINUX.It is tested on MACOS X and LINUX.


timestamp()                                         #time stamp function used to get the date. 
 {
  date +"Scan-Date:-%x || Scan-Time:-%r"
  echo " "
 }

trap ctrl_c INT
ctrl_c(){

	rm -rf *.txt
	rm -rf *.log
    exit
}

function _exterscan {
	clear

echo -e "\033[1;31m      ███████╗██╗  ██╗████████╗███████╗██████╗ ███╗   ██╗ █████╗ ██╗         ███████╗███████╗██████╗ ██╗   ██╗███████╗██████╗     ███████╗ ██████╗ █████╗ ███╗   ██╗\033[0m"
echo -e "\033[1;31m      ██╔════╝╚██╗██╔╝╚══██╔══╝██╔════╝██╔══██╗████╗  ██║██╔══██╗██║         ██╔════╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔══██╗    ██╔════╝██╔════╝██╔══██╗████╗  ██║\033[0m"
echo -e "\033[1;31m      █████╗   ╚███╔╝    ██║   █████╗  ██████╔╝██╔██╗ ██║███████║██║         ███████╗█████╗  ██████╔╝██║   ██║█████╗  ██████╔╝    ███████╗██║     ███████║██╔██╗ ██║\033[0m"
echo -e "\033[1;31m      ██╔══╝   ██╔██╗    ██║   ██╔══╝  ██╔══██╗██║╚██╗██║██╔══██║██║         ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██╔══╝  ██╔══██╗    ╚════██║██║     ██╔══██║██║╚██╗██║\033[0m"
echo -e "\033[1;31m      ███████╗██╔╝ ██╗   ██║   ███████╗██║  ██║██║ ╚████║██║  ██║███████╗    ███████║███████╗██║  ██║ ╚████╔╝ ███████╗██║  ██║    ███████║╚██████╗██║  ██║██║ ╚████║\033[0m"
echo -e "\033[1;31m      ╚══════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝    ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝\033[0m"  
echo " "

while [[ 1 ]]; do
    read -p "Enter an ip address or a Domain name:" ipadd                           #get an ip or url.
	if [[ -z $ipadd ]]; then              												 #checking for the null values in ip adress field.
		read -p " Do you want to Exit?(y/n):[n] " dec
			if [[ $dec == 'y' ]]; then
				clear
				exit
			else
				echo " "
			fi
	fi

	if [[ -n $ipadd ]]; then
				if fping -r 1 $ipadd                                                        #to check the ip is alive or not.
				then
					ip=$(ping -c 1 $ipadd |grep 'bytes from' | awk 'BEGIN{RS=":"} NR==1{print $4}')
  					echo " "
  					echo -e "\033[1;31m IP Validated.The target IP-ADDRESS IS:\033[0m\033[1;33m $ip \033[0m"
  					break

				else
  					echo " "
 					echo -e "\033[1;31mEnter Valid ip Address\033[0m"
  					echo " "
  					read -p " Do you want to Exit?(y/n):[y] " dec
					if [[ $dec == 'n' ]]; then
						echo " "
					else
						exit
					fi
				fi
	fi
done
		day=$(date +"%d-%m-%y")                                                          
		time=$(date +"%H")
		touch External_DATE:"$day"_TIME:"$time".log                                   #creates a file to save the logs of external server scan.
		echo "                                       EXTERNAL SERVER SCAN ">External_DATE:"$day"_TIME:"$time".log
		echo "                                       ---------------------">>External_DATE:"$day"_TIME:"$time".log
		echo " ">>External_DATE:"$day"_TIME:"$time".log

######>>>>>>>                                        >>>>>>>>>>> Nmap Scan starts here <<<<<<<<<<<

		echo -e "\033[1;34m                                   -/-_-\/-_-\/-_-\[\033[0m\033[1;33m Nmap Scan started\033[0m\033[1;34m ]/-_-\/-_-\/-_-\-\033[0m"
		echo -e "\033[1;33m----------------------------------------------------------------------------------------------------------------------------------------------\033[0m"
		echo " "

		echo "                                                                     Nmap Scan Report" >>External_DATE:"$day"_TIME:"$time".log
		echo "-------------------------------------------------------------------------------------" >>External_DATE:"$day"_TIME:"$time".log
		echo " " >> External_DATE:"$day"_TIME:"$time".log
		nmap -A $ip  | tee -a External_DATE:"$day"_TIME:"$time".log | tee temp.txt           #run nmap and saved to two logs.
		touch pr3s.txt 2>/dev/null                                                            #create new file pr3s.txt.
		awk '/open/{print $0}' temp.txt > pr3s.txt                                            #filter the nmap report and save to pr3s.txt for CVE-IDs.
		rm temp.txt 2>/dev/null																  #remove temp file.
		echo " "
		echo -e "\033[1;33m----------------------------------------------------------------------------------------------------------------------------------------------\033[0m"
		echo -e "                                                                                             ~~~~~~~~~~~~~~~\033[1;33m Nmap Scan Completed\033[0m "
		echo " ">>External_DATE:"$day"_TIME:"$time".log
#####>>>>>>>>                                     >>>>>>>>>>>>>> Nmap scan Completed here <<<<<<<<<<<<<<

		echo "-----------------------------------------------------------------------------------             >>END">>External_DATE:"$day"_TIME:"$time".log
		echo " ">>External_DATE:"$day"_TIME:"$time".log
		echo " "
		
		echo " ">>External_DATE:"$day"_TIME:"$time".log
		echo -e "\033[1;34m                                   -/-_-\/-_-\/-_-\[\033[0m\033[1;33m Nikto Scan started\033[0m\033[1;34m ]/-_-\/-_-\/-_-\-\033[0m"
		echo -e "\033[1;33m----------------------------------------------------------------------------------------------------------------------------------------------\033[0m"
		echo " "

######>>>>>>>>                                     >>>>>>>>>>>>>> Nikto scan starts here <<<<<<<<<<<<<<<<

		echo "                                                                     Nikto Scan Report" >>External_DATE:"$day"_TIME:"$time".log
		echo "-------------------------------------------------------------------------------------" >>External_DATE:"$day"_TIME:"$time".log
		echo " " >> External_DATE:"$day"_TIME:"$time".log
		nikto -h $ip  | tee -a External_DATE:"$day"_TIME:"$time".log | tee temp.txt               #run nikto and saved to two logs.
		awk '/Server:/{print $0}' temp.txt >> pr3s.txt                                            #filter the nikto report and save to pr3s.txt for CVE-IDs.
		echo " "
		echo -e "\033[1;33m----------------------------------------------------------------------------------------------------------------------------------------------\033[0m"
		echo -e "                                                                                             ~~~~~~~~~~~~~~~\033[1;33m Nikto Scan Completed\033[0m "
######>>>>>>>>>                                     >>>>>>>>>>>>> Nikto scan completed here <<<<<<<<<<<<<<<

		echo " ">>External_DATE:"$day"_TIME:"$time".log
		echo "-----------------------------------------------------------------------------------             >>END">>External_DATE:"$day"_TIME:"$time".log
		echo " ">>External_DATE:"$day"_TIME:"$time".log
		echo " "
        
######>>>>>>>>>                                     >>>>>>>>>>>>> Golismero scan starts here <<<<<<<<<<<<<<<
         
		echo " ">>External_DATE:"$day"_TIME:"$time".log
		echo -e "\033[1;34m                                   -/-_-\/-_-\/-_-\[\033[0m\033[1;33m Golismero Scan started\033[0m\033[1;34m ]/-_-\/-_-\/-_-\-\033[0m"
		echo -e "\033[1;33m----------------------------------------------------------------------------------------------------------------------------------------------\033[0m"
		echo " "
		echo "                                                                     Golismero  Scan Report" >>External_DATE:"$day"_TIME:"$time".log
		echo "-------------------------------------------------------------------------------------" >>External_DATE:"$day"_TIME:"$time".log
		echo " " >> External_DATE:"$day"_TIME:"$time".log
		pwdir=$(pwd)  																				#store the present directory path to pwdir.
		cd golismero 2>/dev/null 																	#change directory to golismero.
		python golismero.py scan $ip | tee gol.log 2>/dev/null										#Run Golismero.
		mv gol.log $pwdir 2>/dev/null																#moving the file with golismero report.
		cd .. 2>/dev/null																			#back to main directory.
		cat gol.log >>External_DATE:"$day"_TIME:"$time".log  										#copy the golismero report from gol.log.
		echo " "
		echo -e "\033[1;33m----------------------------------------------------------------------------------------------------------------------------------------------\033[0m"
		echo -e "                                                                                             ~~~~~~~~~~~~~~~\033[1;33m Golismero Scan Completed\033[0m "
######>>>>>>>>>                                     >>>>>>>>>>>> Golismero scan completed here <<<<<<<<<<<<<<<<

		echo " ">>External_DATE:"$day"_TIME:"$time".log
		echo "-----------------------------------------------------------------------------------             >>END">>External_DATE:"$day"_TIME:"$time".log
		echo " ">>External_DATE:"$day"_TIME:"$time".log
		echo " "
		mv External_DATE:"$day"_TIME:"$time".log log_files
		rm gol.log 2>/dev/null                                                                      # remove gol.log (2>/dev/null $ 2>&1 is used to hide std err)
		touch CVE-Details_DATE:"$day"_TIME:"$time".log
		
######>>>>>>>>>                                     >>>>>>>>>>>> Fetching CVE Details starts here <<<<<<<<<<<<<<
		day=$(date +"%d-%m-%y")                                                          
		time=$(date +"%H")
		echo "                       CVE DETAILS REGARDING EXTERNAL SERVER SCAN ">CVE-Details_DATE:"$day"_TIME:"$time".log
		echo "                       -------------------------------------------">>CVE-Details_DATE:"$day"_TIME:"$time".log
		echo -e "\033[1;34m                                   -/-_-\/-_-\/-_-\[\033[0m\033[1;33mFetching CVE Details.. \033[0m\033[1;34m ]/-_-\/-_-\/-_-\-\033[0m"
		echo -e "\033[1;33m----------------------------------------------------------------------------------------------------------------------------------------------\033[0m"
		echo " ">>CVE-Details_DATE:"$day"_TIME:"$time".log
 		j=1                                                                                        # j is the list of CVE's 
		while read f                                                                               # A while loop to send line by line to the Api.
		do                                                 
			p=$(curl -s "https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=$f" |awk 'BEGIN{RS="<";FS=">"} /name=CVE/{print $2}')        #to Extract CVE-ID's for keywords in nmap & nikto scan.                       
			# curl -s "https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=$f" |awk 'BEGIN{RS="<";FS=">"} /name=CVE/{print $2,NR}'

			for i in $p                                                                            #for loop, to send CVE-ID one-by-one to api.    
			do
				echo -e "\033[1;31m $j.          \033[0m\033[1;33m $i \033[0m" 
				echo " ">>CVE-Details_DATE:"$day"_TIME:"$time".log
				echo " $j. ">>CVE-Details_DATE:"$day"_TIME:"$time".log
				echo "-----------------------------------------------------------------------------------------------------------">>CVE-Details_DATE:"$day"_TIME:"$time".log
				echo -e "\033[1;33m--------------------------------------------------------------------------------------------------------------------------------------------- \033[0m"
				json=$(curl -s "https://cve.circl.lu/api/cve/$i" | jq '{Name :.id,Summary:.summary,Solution:.references}' |tee -a CVE-Details_DATE:"$day"_TIME:"$time".log)       
																									#API to fetch the CVE Details.(name,summary,References or solution)
				echo -e "\033[1;32m $json \033[0m"
				((j++))																				
				echo " "
				echo " "
			done                                           
		done < pr3s.txt																				#file with filtered lines of scan report.                                       
		echo -e " \033[1;31m----------------------------------------------------------------------------                     ~~~~~~~~~~\033[0m\033[1;31m >>> END <<<\033[0m "
		echo "------------------------------------------------------>>>END<<<" >> CVE-Details_DATE:"$day"_TIME:"$time".log
		mv CVE-Details_DATE:"$day"_TIME:"$time".log log_files 2>/dev/null
		rm temp.txt 2>/dev/null
#####>>>>>>>>>>>>>                                 >>>>>>>>>>>>>>>>> all CVE is fetched <<<<<<<<<<<<<<<<<<<<<<<<
	rm -rf *.txt
	rm -rf *.log
}


function _CVE {
	kill=0
	while [[ $kill -eq 0 ]]; do
		clear
		echo -e '\033[37m          ███████╗██╗  ██╗██████╗ ██╗      ██████╗ ██████╗ ███████╗     ██████╗██╗   ██╗███████╗ \033[0m'                                                                                                                                                                                                                                                                                                                                                                                                                                           
        echo -e '\033[37m          ██╔════╝╚██╗██╔╝██╔══██╗██║     ██╔═══██╗██╔══██╗██╔════╝    ██╔════╝██║   ██║██╔════╝ \033[0m'                                                                                                                                                                                                                                                                                                                                                                                                                                           
        echo -e '\033[37m          █████╗   ╚███╔╝ ██████╔╝██║     ██║   ██║██████╔╝█████╗      ██║     ██║   ██║█████╗   \033[0m'                                                                                                                                                                                                                                                                                                                                                                                                                                           
        echo -e '\033[37m          ██╔══╝   ██╔██╗ ██╔═══╝ ██║     ██║   ██║██╔══██╗██╔══╝      ██║     ╚██╗ ██╔╝██╔══╝   \033[0m'                                                                                                                                                                                                                                                                                                                                                                                                                                           
        echo -e '\033[37m          ███████╗██╔╝ ██╗██║     ███████╗╚██████╔╝██║  ██║███████╗    ╚██████╗ ╚████╔╝ ███████╗ \033[0m'                                                                                                                                                                                                                                                                                                                                                                                                                                           
        echo -e '\033[37m          ╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝     ╚═════╝  ╚═══╝  ╚══════╝ \033[0m'  
        echo " "
		echo -e "\033[1;33m           You can search for CVE deatils here by,entering a product name or any keyword(or a phrase) .[Ex: nikto] \033[0m "
		echo -e "\033[1;33m           if you enter a keyword, it will Display the CVE-ID's and then choose CVE-IDs to fetch details.\033[0m "
		echo " "
		echo "         "
		echo "         "	
		p=$(echo -e "\033[1;4;37;40mSelect a Search:\033[0m")
		s=$(echo "-----------------------------------------------")
		PS3=" $p : "

		sona1=$(echo -e "\033[31mSearch by KEYWORD (or) a KEYWORD PHRASE.\033[0m")
		sona2=$(echo -e "\033[31mSearch by CVE-ID.\033[0m")
		quit=$(echo -e "\033[31mQuit or Exit\033[0m")
        
		select sonnas in "$sona1" "$sona2" "$quit"
		do
			case $sonnas in
						$sona1) while [[ 1 ]]; do
									echo -e "\033[1;31m enter a keyword or a phrase :\033[0m" 
									read -p " " key
									if [[ -n $key ]]; then
										echo " "
										clear
										echo " "
										echo -e "\033[1;37m wait for a second . . .\033[0m"
										curl -s "https://cve.mitre.org/cgi-bin/cvekey.cgi?keyword=$key" |awk 'BEGIN{RS="<";FS=">"} /name=CVE/{print $2}' > cvelist.txt
										cvelist=$(awk '{print $0}' cvelist.txt)
										cve=$(awk 'BEGIN{OFS=". ";} {print NR,$0}' cvelist.txt)
										if [[ -n $cve ]]; then
#####>>>>>>>>>>>>                                   >>>>>>>>>>>>>>>>> fetching CVE ID <<<<<<<<<<<<<<<<<	
											echo -e "\033[1;31m The CVE-ID's are: \033[0m" 
											echo -e "\033[1;33m $cve \033[0m" 																					 #filtering a HTML page.                 
											echo " "
											echo " "
											while [[ 1 ]]; do
												echo -e "\033[1;32m SELECT A METHOD FROM BELOW\033[0m"
												echo " "
												echo -e "\033[1;31m         1. a specific CVE-ID.\033[0m"
												echo -e "\033[1;31m         2. a certain Number of CVE-IDs from the list starting.\033[0m"
												echo -e "\033[1;31m         3. all the CVE-IDs listed above.\033[0m"
	                                        	echo -e "\033[1;31m         4. Exit or Quit \033[0m"								
												echo " "
												echo -e "\033[1;31mfetch CVE-Details for - \033[0m"
												read -p "Enter an option number:" opt
												if [[ $opt == 1 ]]; then
													local plus=0
													j=1
													while [[ $plus == 0 ]]; do                                           							  #loop to get CVE details of user-Defined CVE.
														echo -e "\033[1;31m Enter a CVE-ID from above list :\033[0m" 
														read -p " " ID
														day=$(date +"%d-%m-%y")
														time=$(date +"%H-%M")
														if [[ -n $ID ]]; then
															echo -e "\033[1;31m $j.          \033[0m\033[1;33m $ID \033[0m"
															echo " ">>Explore-CVE_DATE:"$day"_TIME:"$time".log
															echo "-----------------------------------------------------------------------------------------------------------">>Explore-CVE_DATE:"$day"_TIME:"$time".log
															echo -e "\033[1;33m--------------------------------------------------------------------------------------------------------------------------------------------- \033[0m "
															json=$(curl -s "https://cve.circl.lu/api/cve/$ID" | jq '{Name :.id,Summary:.summary,Solution:.references}' |tee -a Explore-CVE_DATE:"$day"_TIME:"$time".log)
																											  #fetching CVE details for a CVE ID
															echo -e "\033[1;32m $json \033[0m"
															((j++))
															mv Explore-CVE_DATE:"$day"_TIME:"$time".log log_files
															echo " "
															echo " "
															read -p "Want to search an another CVE-ID? (y/n):[n]" decision									  #getting user choice to cont with another CVE-ID.
															if [[ $decision == "y" ]]; then 
																plus=0
															elif [[ $decision == "n" ]]; then
																plus=1
																break
															else
																plus=1
																break
															fi
														else	
															read -p "Continue? (y/n):[n]" decision1									  #getting user choice to cont with another CVE-ID.
															if [[ $decision1 == "y" ]]; then 
																echo " "
															elif [[ $decision1 == "n" ]]; then
																echo -e " \033[1;31m----------------------------------------------------------------------------                     ~~~~~~~~~~\033[0m\033[1;31m >>> END <<<\033[0m "
																break
															else
																echo -e " \033[1;31m----------------------------------------------------------------------------                     ~~~~~~~~~~\033[0m\033[1;31m >>> END <<<\033[0m "
																break
															fi
														fi
													done
											

												elif [[ $opt == 2 ]]; then
													tncve=$(awk 'END{print NR}' cvelist.txt)
													read -p "Enter a maximum number upto which the CVE-Details are to be fetched-(within $tncve): " rangenum
													if [[ -n $rangenum ]]; then
														if [[ $rangenum -gt $tncve ]]; then
															echo -e "\033[1;33m your choice exceeds the no of CVE-IDs: \033[0m"
															read -p "Do you want to go with all CVE-IDs:(y/n)[n] " sel
															if [[ $sel == 'y' ]]; then
																day=$(date +"%d-%m-%y")
																time=$(date +"%H")
																j=1                                                                                        # j is the list of CVE's 
																for i in $cvelist                                                                          #for loop, to send CVE-ID one-by-one to api.    
																do
																	echo -e "\033[1;31m $j.          \033[0m\033[1;33m $i \033[0m" 
																	echo " ">>Explore-CVE_DATE:"$day"_TIME:"$time".log
																	echo " $j. ">>Explore-CVE_DATE:"$day"_TIME:"$time".log
																	echo "-----------------------------------------------------------------------------------------------------------">>Explore-CVE_DATE:"$day"_TIME:"$time".log
																	echo -e "\033[1;33m--------------------------------------------------------------------------------------------------------------------------------------------- \033[0m"
																	json=$(curl -s "https://cve.circl.lu/api/cve/$i" | jq '{Name :.id,Summary:.summary,Solution:.references}' |tee -a Explore-CVE_DATE:"$day"_TIME:"$time".log)       
																									#API to fetch the CVE Details.(name,summary,References or solution)
																	echo -e "\033[1;32m $json \033[0m"
																	((j++))																				
																	echo " "
																	echo " "
																done 
																mv Explore-CVE_DATE:"$day"_TIME:"$time".log log_files          
															elif [[ $sel == 'n' ]]; then
																echo " "
																echo -e "\033[1;33m Enter within the limit. \033[0m"
															else
																echo " "
													   			echo -e "\033[1;33m Enter within the limit. \033[0m"                                                     
															fi
														elif [[ $rangenum -lt $tncve ]]; then
															j=0                 
															day=$(date +"%d-%m-%y")
															time=$(date +"%H")                                                                   # j is the list of CVE's 
															for i in $cvelist                                                                            #for loop, to send CVE-ID one-by-one to api.    
															do
																if [[ $j -lt $rangenum ]]; then
																	((j++))
																	echo -e "\033[1;31m $j.          \033[0m\033[1;33m $i \033[0m" 
																	echo " ">>Explore-CVE_DATE:"$day"_TIME:"$time".log
																	echo " $j. ">>Explore-CVE_DATE:"$day"_TIME:"$time".log
																	echo "-----------------------------------------------------------------------------------------------------------">>Explore-CVE_DATE:"$day"_TIME:"$time".log
																	echo -e "\033[1;33m--------------------------------------------------------------------------------------------------------------------------------------------- \033[0m"
																	json=$(curl -s "https://cve.circl.lu/api/cve/$i" | jq '{Name :.id,Summary:.summary,Solution:.references}' |tee -a Explore-CVE_DATE:"$day"_TIME:"$time".log)       
																									#API to fetch the CVE Details.(name,summary,References or solution)
																	echo -e "\033[1;32m $json \033[0m"																				
																	echo " "
																	echo " "
																fi
															done
															mv Explore-CVE_DATE:"$day"_TIME:"$time".log log_files
														else
															echo -e "\033[1;33m enter a valid value (in numbers). \033[0m"
														
														fi
													else
														 read -p "Do you want to exit(y/n):[n]" sel1
													 	if [[ $sel1 == y ]]; then
													 		echo " "
													 	elif [[ $sel1 == n ]]; then
													 		break
													 	else
													 		break	
													 	fi
													fi
												elif [[ $opt == 3 ]]; then
													j=1   
													day=$(date +"%d-%m-%y")
													time=$(date +"%H")                                                                                     # j is the list of CVE's 
													for i in $cvelist                                                             #for loop, to send CVE-ID one-by-one to api.    
													do
														echo -e "\033[1;31m $j.          \033[0m\033[1;33m $i \033[0m" 
														echo " ">>Explore-CVE_DATE:"$day"_TIME:"$time".log
														echo " $j. ">>Explore-CVE_DATE:"$day"_TIME:"$time".log
														echo "-----------------------------------------------------------------------------------------------------------">>Explore-CVE_DATE:"$day"_TIME:"$time".log
														echo -e "\033[1;33m--------------------------------------------------------------------------------------------------------------------------------------------- \033[0m"
														json=$(curl -s "https://cve.circl.lu/api/cve/$i" | jq '{Name :.id,Summary:.summary,Solution:.references}' |tee -a Explore-CVE_DATE:"$day"_TIME:"$time".log)       
																						#API to fetch the CVE Details.(name,summary,References or solution)
														echo -e "\033[1;32m $json \033[0m"
														((j++))																				
														echo " "
														echo " "
													done
													mv Explore-CVE_DATE:"$day"_TIME:"$time".log log_files
												elif [[ $opt == 4 ]]; then
														clear
														break
												else
														echo -e "\033[1;33m Enter a valid option.  \033[0m"
												fi
											done
											echo -e " \033[1;31m----------------------------------------------------------------------------                     ~~~~~~~~~~\033[0m "
											echo "------------------------------------------------------>>>END<<<">> Explore-CVE_DATE:"$day"_TIME:"$time".log
											mv Explore-CVE_DATE:"$day"_TIME:"$time".log log_files &>/dev/null
										else 
											echo -e "\033[1;33m Sorry,we dont find any CVE-ID's Related to your keyword.(╸▁╺) \033[0m " 
											echo " "    
										fi
									else	
										read -p "Continue search? (y/n):[n]" decision1									  #getting user choice to cont with another CVE-ID.
										if [[ $decision1 == "y" ]]; then 
											echo " "
										elif [[ $decision1 == "n" ]]; then
											echo -e " \033[1;31m----------------------------------------------------------------------------                     ~~~~~~~~~~\033[0m\033[1;31m >>> END <<<\033[0m "
											clear
											break
										else
											echo -e " \033[1;31m----------------------------------------------------------------------------                     ~~~~~~~~~~\033[0m\033[1;31m >>> END <<<\033[0m "
											clear
											break
										fi
									fi  
								done
								echo "------------------------------------------------------>>>END<<<">> Explore-CVE_DATE:"$day"_TIME:"$time".log
		
								mv Explore-CVE_DATE:"$day"_TIME:"$time".log log_files
								break ;;

						$sona2) local plus=0
								j=1
								while [[ $plus == 0 ]]; do                                           							  #loop to get CVE details of user-Defined CVE.
									echo -e "\033[1;31m Enter a CVE-ID :\033[0m" 
									read -p " " ID
									if [[ -n $ID ]]; then
										echo -e "\033[1;31m $j.          \033[0m\033[1;33m $ID \033[0m"
										day=$(date +"%d-%m-%y")
										time=$(date +"%H-%M-%S")																					 #filtering a HTML page.                 
									   	touch Explore-CVE_DATE:"$day"_TIME:"$time".log
										echo " ">>Explore-CVE_DATE:"$day"_TIME:"$time".log
										echo "-----------------------------------------------------------------------------------------------------------">>Explore-CVE_DATE:"$day"_TIME:"$time".log
										echo -e "\033[1;33m--------------------------------------------------------------------------------------------------------------------------------------------- \033[0m "
										json=$(curl -s "https://cve.circl.lu/api/cve/$ID" | jq '{Name :.id,Summary:.summary,Solution:.references}' |tee -a Explore-CVE_DATE:"$day"_TIME:"$time".log)
																															  #fetching CVE details for a CVE ID
										echo -e "\033[1;32m $json \033[0m"
										((j++))
										echo " "
										echo " "
										read -p "Want to search an another CVE-ID? (y/n):[n]" decision									  #getting user choice to cont with another CVE-ID.
										echo " "
										if [[ $decision == "y" ]]; then 
											plus=0
										elif [[ $decision == "n" ]]; then
											plus=1
											clear
											break
										else
											plus=1
											clear
											break
										fi
									else 
										echo -e "\033[1;33m Empty value detected./-_-\ \033[0m"
										read -p "Want to try again? (y/n):[n]" decision									  #getting user choice to cont with another CVE-ID.
										echo " "
										if [[ $decision == "y" ]]; then 
											echo " "
											plus=0
										elif [[ $decision == "n" ]]; then
											plus=1
											clear
											break
										else
											plus=1
											clear
											break
										fi
									fi
								done	
								echo -e " \033[1;31m----------------------------------------------------------------------------                     ~~~~~~~~~~\033[0m "
								echo "------------------------------------------------------>>>END<<<">> Explore-CVE_DATE:"$day"_TIME:"$time".log
		
								mv Explore-CVE_DATE:"$day"_TIME:"$time".log log_files 
								break ;;

						$quit)  clear
								kill=1
								break ;;

							*) optnum=$(echo -e "\033[5;30;47moption numbers\033[0m")
								echo "enter the" $optnum "provided above."
								break ;;
			esac
		done
	done
	rm -rf *.txt
	rm -rf *.log
}


function _interscan {
clear
echo -e '\033[33m       ██╗███╗   ██╗████████╗███████╗██████╗ ███╗   ██╗ █████╗ ██╗         ███████╗███████╗██████╗ ██╗   ██╗███████╗██████╗     ███████╗ ██████╗ █████╗ ███╗   ██╗ \033[0m'
echo -e '\033[33m       ██║████╗  ██║╚══██╔══╝██╔════╝██╔══██╗████╗  ██║██╔══██╗██║         ██╔════╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔══██╗    ██╔════╝██╔════╝██╔══██╗████╗  ██║ \033[0m'
echo -e '\033[33m       ██║██╔██╗ ██║   ██║   █████╗  ██████╔╝██╔██╗ ██║███████║██║         ███████╗█████╗  ██████╔╝██║   ██║█████╗  ██████╔╝    ███████╗██║     ███████║██╔██╗ ██║ \033[0m'
echo -e '\033[33m       ██║██║╚██╗██║   ██║   ██╔══╝  ██╔══██╗██║╚██╗██║██╔══██║██║         ╚════██║██╔══╝  ██╔══██╗╚██╗ ██╔╝██╔══╝  ██╔══██╗    ╚════██║██║     ██╔══██║██║╚██╗██║ \033[0m'
echo -e '\033[33m       ██║██║ ╚████║   ██║   ███████╗██║  ██║██║ ╚████║██║  ██║███████╗    ███████║███████╗██║  ██║ ╚████╔╝ ███████╗██║  ██║    ███████║╚██████╗██║  ██║██║ ╚████║ \033[0m'
echo -e '\033[33m       ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝    ╚══════╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝    ╚══════╝ ╚═════╝╚═╝  ╚═╝╚═╝  ╚═══╝ \033[0m'
echo " "

day=$(date +"%d-%m-%y")
time=$(date +"%H")
touch INTERNAL_DATE:"$day"_TIME:"$time".log
echo "                             INTERNAL SERVER SCAN">INTERNAL_DATE:"$day"_TIME:"$time".log
echo "--------------------------------------------------------------------------">>INTERNAL_DATE:"$day"_TIME:"$time".log
lynis audit system |tee -a INTERNAL_DATE:"$day"_TIME:"$time".log                        #running lynis in MAC.
echo "------------------------------------------------------>>>END<<<"|tee -a INTERNAL_DATE:"$day"_TIME:"$time".log
mv INTERNAL_DATE:"$day"_TIME:"$time".log log_files
rm -rf *.txt
rm -rf *.log
}


#####>>>>>>>>                            >>>>>>>>>>>Detecting OS<<<<<<<<<<<<<<

chmod u+x Progress.sh
if [ "$(uname -s)" == "Linux" ]; then
	chmod u+x Linux-apps.sh
	sudo ./Linux-apps.sh
elif [ "$(uname -s)" == "Darwin" ]; then
	chmod u+x Mac-apps.sh
	./Mac-apps.sh
else
      echo -e "\033[1;31m Your OS does not support this shell {~_~}. \033[0m"
fi
mkdir -p log_files
#####>>>>>>>>>>>>>                                          >>>>>>>> starting Pronoxis <<<<<<<<< 
plus=0
while [[ $plus -eq 0 ]]; do
	clear
	echo -e '\033[37m                     ██████╗ ██████╗  ██████╗ ███╗   ██╗ ██████╗ \033[0m\033[31m██╗  ██╗\033[0m\033[37m██╗███████╗ \033[0m'
	echo -e '\033[37m                     ██╔══██╗██╔══██╗██╔═══██╗████╗  ██║██╔═══██╗\033[0m\033[31m╚██╗██╔╝\033[0m\033[37m██║██╔════╝ \033[0m'
	echo -e '\033[37m                     ██████╔╝██████╔╝██║   ██║██╔██╗ ██║██║   ██║\033[0m\033[31m ╚███╔╝ \033[0m\033[37m██║███████╗ \033[0m'
	echo -e '\033[37m                     ██╔═══╝ ██╔══██╗██║   ██║██║╚██╗██║██║   ██║\033[0m\033[31m ██╔██╗ \033[0m\033[37m██║╚════██║ \033[0m'
	echo -e '\033[37m                     ██║     ██║  ██║╚██████╔╝██║ ╚████║╚██████╔╝\033[0m\033[31m██╔╝ ██╗\033[0m\033[37m██║███████║ \033[0m'
	echo -e '\033[37m                     ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝ \033[0m\033[31m╚═╝  ╚═╝\033[0m\033[37m╚═╝╚══════╝ \033[0m'
	echo -e '\033[37m                                                                 \033[0m\033[31mSecurity\033[0m\033[37m at its Basic form \033[0m'
	echo " "
	echo -e '\033[37m                                              Developed by team heller$ \033[0m'''
	echo " "
	echo -e "                                                                                            \033[1;31m`timestamp`\033[0m"
	echo " "
	echo " "

# plus=0
	
# 	while [[ $plus -eq 0 ]]; do
		echo "         "
		echo "         "	
		p=$(echo -e "\033[1;4;37;40mSelect a Scan\033[0m")
		s=$(echo "-----------------------------------------------")
		PS3=" $p : "

		sona1=$(echo -e "\033[31mEXTERNAL SERVER SCAN\033[0m")
		sona2=$(echo -e "\033[31mINTERNAL SERVER SCAN\033[0m")
		sona3=$(echo -e "\033[31mEXPLORE CVE DETAILS\033[0m")
		quit=$(echo -e "\033[37;41mQuit or Exit\033[0m")
        
		select sonnas in "$sona1" "$sona2" "$sona3" "$quit"
		do
			case $sonnas in
						$sona1)_exterscan 
								break ;;					
						 $sona2) _interscan
								break ;;
						 $sona3)_CVE
								break;;

						$quit)  clear
								plus=1
								break ;;

							*) optnum=$(echo -e "\033[5;30;47moption numbers\033[0m")
								echo "enter the" $optnum "provided above."
								break ;;
			esac
		done
	done
	echo -e "\033[37m░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░          <<<<<<<<<\033[0m\033[31m Pronoxis Exited \033[0m\033[37m>>>>>>>>>           ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░\033[0m"
	echo " "

#####>>>>>>>                                                           >>>>>>>> END OF CODE <<<<<<<<
	