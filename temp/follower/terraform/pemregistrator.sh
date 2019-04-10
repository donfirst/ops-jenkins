#!/bin/bash
file="/tmp/id_rsa"
if [ -f "$file" ]
then
	echo "$file found." > /tmp/znaleziono.txt
  cp /tmp/id_rsa /home/jenkins/.ssh/id_rsa
	chmod 400 /home/jenkins/.ssh/id_rsa
  eval `/usr/bin/ssh-agent -s`
  /usr/bin/ssh-agent /home/jenkins/.ssh/id_rsa
else
	echo "$file not found." > /tmp/wynik.txt
fi
