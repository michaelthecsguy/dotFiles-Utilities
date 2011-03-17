#!/bin/bash
clear

MAIN_OPTIONS="start-the-hub start-all-RCs start-a-RC kill-all-RCs kill-a-RC exit"
RC_SERVERS="10.45.14.56 10.45.14.86 10.45.14.152 return"
SELENIUM_HUB_DIR=selenium-grid/
SELENIUM_RCGRID_DIR=selenium-grid/
SELENIUM_RC_DIR=selenium-rc/

USER=${USERNAME:-$(whoami)}
HOST=${HOSTNAME:-$(hostname)}

SSHCONNECTION = ssh -l ${USER} ${HOST}

E_NOTROOT=87

echo "Please choose the following options by entering the number 1-5"
select opt in $MAIN_OPTIONS; do
	if [ "$opt"   = "start-the-hub" ]; then
		cd $SELENIUM_HUB_DIR
		ant launch-hub
		echo "Started the Selenium Hub"

	elif [ "$opt" = "start-all-RCs" ]; then
		echo "Started all RCs for Grid Hub"

	elif [ "$opt" = "start-a-RC" ]; then
		select server_opt in $RC_SERVERS; do
			if [ "$server_opt" = "10.45.14.56" ]; then
								
				echo "sshd"
				echo "Started a RC for Grid"
				echo
				break
			
			elif [ "$server_opt" = "10.45.14.86" ]; then
				echo "sshd"
				echo "Started a RC for Grid"
				echo
				break
			
			elif [ "$server_opt" = "10.45.14.152" ]; then
				echo "sshd"
				echo "Started a RC for Grid and Return to Main Menu"
				echo
				break
			
			elif [ "$server_opt" = "return" ]; then
				echo "Return to Main Menu"
				echo
				break	
			
			else
				echo "Bad option that you enter!!!"
				echo "Press 'return' key again to see all the available options"
			fi
		done	

	elif [ "$opt" = "kill-all-RCs" ]; then
		echo "Killing all the process"

	elif [ "$opt" = "kill-a-RC" ]; then
		select server_opt in $RC_SERVERS; do
			if [ "$server_opt" = "10.45.14.56" ]; then
				echo "sshd"
				echo "Killed a RC for Grid"
				echo
				break
			
			elif [ "$server_opt" = "10.45.14.86" ]; then
				echo "sshd"
				echo "Killed a RC for Grid"
				echo
				break
			
			elif [ "$server_opt" = "10.45.14.152" ]; then
				echo "sshd"
				echo "Killed a RC for Grid and Return to Main Menu"
				echo
				break
			
			elif [ "$server_opt" = "return" ]; then
				echo "Return to Main Menu"
				echo
				break	
			
			else
				echo "Bad option that you enter!!!"
				echo "Press 'return' key again to see all the available options"
			fi
		done

	elif [ "$opt" = "exit" ]; then
		echo "Quitting the shell script"
		exit

	else
		echo "Bad option that you enter!!!"
		echo "Press return key again to see all the available options"

	fi
done

