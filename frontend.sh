#!/bin/bash

source ./common.sh

check_root

dnf install nginx -y &>>$LOGFILE
VALIDATE $? "Installing nginx"

systemctl enable nginx &>>$LOGFILE
VALIDATE $? "Enabling nginx"

systemctl start nginx &>>$LOGFILE
VALIDATE $? "Starting nginx"

rm -rf /usr/share/nginx/htmll/* &>>$LOGFILE
VALIDATE $? "Remove existing content"

curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE
VALIDATE $? "Downloading frontend code"

cd /usr/share/nginx/html &>>$LOGFILE
VALIDATE $? "Open the html file"

unzip /tmp/frontend.zip &>>$LOGFILE
VALIDATE $? "Unzip the file"
 
cp /home/ec2-user/03-expense-shell-script/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
VALIDATE $? "Copied frontend service"
 
systemctl restart nginx &>>$LOGFILE
VALIDATE $? "Restarting nginx"