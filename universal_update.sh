
#!/bin/bash

release_file=/etc/os-release
logfile=/var/log/updater.log
errorlog=/var/log/update_error.log


if grep -q "Arch" $release_file
then 
	# Arch
	sudo pacman -Syu 1>>$logfile 2>>@errorlog 
	if [ $? -ne 0 ]
	then 
		echo "An error occured, please check the $errorlog file."
	fi

fi

if grep -q "Pop" $release_file || grep -q "Ubuntu" $release_file
 then
	# Debian 
	
	sudo apt update>>@logfile 2>>$errorlog
	sudo apt dist-upgrade 1>> $logfile 2>>$errorlog

	if [ $? -ne 0 ]
	then 
		echo "An error occured, please check the $errorlog file."
	fi

fi

