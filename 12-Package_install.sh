#!/bin/bash
ID=$(id -u)

VALIDATE(){
    if [ $? -ne 0 ]
    then 
        echo "ERROR:package installation is unsuccessfull"
        exit 1
    else 
        echo "package installation  successfully"
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
VALIDATE
yum install git -y
VALIDATE