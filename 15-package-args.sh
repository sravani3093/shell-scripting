#!/bin/bash
ID=$(id -u) #to check root user login
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

TIMESTAMP=$(date +%F-%H-%M-%S)
LOGFILE=/tmp/$0_$TIMESTAMP.log
echo "script started executing at : $TIMESTAMP " &>>$LOGFILE

VALIDATE() { #function created to validate installation of packages
    if [ $1 -ne 0 ]
    then 
       echo -e "$2  ....... $R FAILED $N"
    else
       echo -e "$2 ........  $G SUCCESSFULLY $N"
    fi #reverse of if end of if loop
}

if [ $ID -ne 0 ] #if id 0 then it is root user 
then 
    echo -e "$R please run the script with root user $N"
    exit 1
else
    echo -e "$G proceeding to run the package installation $N"
fi #reverse of if end of if loop
# mysql postfix are package
#first package will be taken as argument 
#$@ represent all arguments echoing
for PACKAGE in $@
do
    rpm -qa | grep -i $PACKAGE &>>$LOGFILE  #checking the package installation file in server
    if [ $? -ne 0 ] #if not installed
    then 
        yum install $PACKAGE -y &>>$LOGFILE #installing the package
        VALIDATE $? "INSTALLATION OF $PACKAGE"
    else
        echo "$PACKAGE IS ALREADY INSTALLED.... $G SKIPPING $N" #if package is already installed skipping 
    fi
done #end of for loop
 
 echo " The number of arguments passed in $0 are : $# " #how many arguments passed in the script
