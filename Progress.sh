#!/bin/bash
#Progress Designed for Pronoxis.
#author		 	  :Vi5hnu
#date             :18/01/2019
#version          :1    

 BAR="██████████████████████████████████████████████████████████████████████████████████████████████"   # this is full bar, mine is 20 chars
BAR1="░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
 
for i in {1..100}; do
	echo -ne "\033[1;33m\r${BAR1} \033[0m   "
    echo -ne "\033[1;32m\r${BAR:0:$i}\r[${i}.00%] \033[0m " # print $i chars of $BAR from 0 position
    sleep .2
done
echo " " 

#####>>>>>>>                         >>>>>>>> END OF CODE <<<<<<<<<<<<<<<<<<



#BAR="▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓"