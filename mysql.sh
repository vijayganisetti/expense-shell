#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$TIMESTAMP-$SCRIPTNAME.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"


VALIDATE() {
    if [ $1 -ne 0 ]
then
echo -e "$2  is failure $R"
exit 1
else
echo -e "$2  is success $G"
fi 
}

if [ $USERID -ne 0 ]
then
echo "plz run with sudo user"
exit 1
else 
echo "you are a super user"
fi

dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "installing mysql"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "enabling mysqld"   

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "staring the mysqld"

mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
VALIDATE $? "setting up the root password"