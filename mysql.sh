# #!/bin/bash

# USERID=$(id -u)
# TIMESTAMP=$(date +%F-%H-%M-%S)
# SCRIPTNAME=$(echo $0 | cut -d "." -f1)
# LOGFILE=/tmp/$TIMESTAMP-$SCRIPTNAME.log
# R="\e[31m"
# G="\e[32m"
# Y="\e[33m"
# N="\e[0m"


# VALIDATE() {
#     if [ $1 -ne 0 ]
# then
# echo -e "$2..$R is failure $N"
# exit 1
# else
# echo -e "$2...$G is success $N"
# fi 
# }

# if [ $USERID -ne 0 ]
# then
# echo "plz run with sudo user"
# exit 1
# else 
# echo "you are a super user"
# fi

# dnf install mysql-server -y &>>$LOGFILE
# VALIDATE $? "installing mysql"

# systemctl enable mysqld &>>$LOGFILE
# VALIDATE $? "enabling mysqld"   

# systemctl start mysqld &>>$LOGFILE
# VALIDATE $? "staring the mysqld"

# mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
# VALIDATE $? "setting up the root password"

#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
echo "Please enter DB password:"
read -s mysql_root_password

VALIDATE(){
   if [ $1 -ne 0 ]
   then
        echo -e "$2...$R FAILURE $N"
        exit 1
    else
        echo -e "$2...$G SUCCESS $N"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "Please run this script with root access."
    exit 1 # manually exit if error comes.
else
    echo "You are super user."
fi


dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "Installing MySQL Server"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enabling MySQL Server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Starting MySQL Server"

 mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
 VALIDATE $? "Setting up root password"

# #Below code will be useful for idempotent nature
# mysql -h db.daws78s.online -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOGFILE
# if [ $? -ne 0 ]
# then
#     mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
#     VALIDATE $? "MySQL Root password Setup"
# else
#     echo -e "MySQL Root password is already setup...$Y SKIPPING $N"
# fi
