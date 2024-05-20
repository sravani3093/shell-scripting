#!/bin/bash
ID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%s)
Log_file=/tmp/$0_$TIMESTAMP.log
echo "script started executing at $TIMESTAMP" &>>$Log_file
R="\e[31m"
G="\e[32m"
N="\e[0m"

VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e " ERROR: $2 is  $R unsuccessfull $N"
        exit 1
    else 
        echo -e " $2 is  $G successfully $N"
    fi
}

if [ $ID -ne 0 ]
then
   echo  -e "ERROR: $R you are not root user,run with root user $N"
   exit 1 #you can give other than 0
else
   echo -e " $G you are root user $N"
fi

yum install mysql -y &>>$Log_file
VALIDATE $? "MySQL"
yum install git -y &>>$Log_file
VALIDATE $? "GIT"