#!/bin/bash
ID=$(id -u)

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo "ERROR: $2 is unsuccessfull"
        exit 1
    else 
        echo " $2 is successfully"
    fi
}

if [ $ID -ne 0 ]
then
   echo "ERROR:you are not root user,run with root user"
   exit 1 #you can give other than 0
else
   echo "you are root user"
fi

yum install mysql -y
VALIDATE $? "MySQL"
yum install git -y
VALIDATE $? "GIT"