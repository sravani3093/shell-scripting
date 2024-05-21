#!/bin/bash
ID=$(id -u) #to check root user login
R=\e[31m
G=\e[32m
Y=\e[33m
N=\e[0m
TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE=/var/log/messages/$0_$TIMESTAMP.log

VALIDATE() {
    if [ $1 -ne 0 ]
    then 
       echo -e "$2 IS INSTALLATION IS .......$R FAILED $N"
    else
       echo -e "$2 IS INSTALLED........ $G SUCCESSFULLY $N"
    fi
}

echo "script started executing at : $TIMESTAMP" &>>$LOGFILE

if[ $ID -ne 0 ]
then 
    echo -e " $R please run the script with root user $N"
    exit 1
else
    echo -e " $G proceeding to run the package installation $N"
fi
for PACKAGE in $@
do
    yum installed $PACKAGE &>>$LOGFILE
    if [ $? -ne 0 ]
    then 
        echo "$PACKAGE IS ALREADY INSTALLED.... $Y SKIPPING $N"
    else
        yum install $PACKAGE &>>$LOGFILE
        VALIDATE $? "$PACKAGE"

    fi
done