#!/bin/bash

source ./common.sh

check_root

 set -e

 set -x

echo "please enter DB password:"
read mysql_root_password

dnf install mysql-server -y &>>$LOGFILE
#VALIDATE $? "Installing MySQL server"

systemctl enable mysqld &>>$LOGFILE
#VALIDATE $? "Enabling MySQL server"

systemctl start mysqld &>>$LOGFILE
#VALIDATE $? "Starting MySQL server"

# mysql_secure_installation --set-root-pass ExpenseApp@1 &>>$LOGFILE
# VALIDATE $? "Setting up root password"

# below code will be useful for idempotent nature
 
mysql -h db.daws78s.xyz -uroot -p${mysql_root_password} -e 'SHOW DATABASES' &>>$LOGFILE
if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ${mysql_root_password}
    #VALIDATE $? "Setting up root password"
else
    echo -e "MySQL root password is already setup.. $Y SKIPPING $n"
fi