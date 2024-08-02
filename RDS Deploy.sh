#!/bin/bash

# Install necessary packages
sudo yum install git -y
sudo yum install curl -y

# Download the SQL file
curl -L -o /home/ec2-user/cloud_fyp.sql https://raw.githubusercontent.com/iwanttobeagithub/fyp_cloud/6338406359bc476665c4f642345265f33f7c40f7/cloud_fyp.sql

# Update packages and install MySQL client
sudo yum update -y
sudo yum install -y mysql

# Set RDS endpoint
export RDS_ENDPOINT=fyprds.cjmygavhp6fg.us-east-1.rds.amazonaws.com

# Wait for a bit to ensure services are up
sleep 60

# Create the database if it doesn't exist
mysql -h ${RDS_ENDPOINT} -P 3306 -u admin -pcloudfyp -e "CREATE DATABASE IF NOT EXISTS cloud_fyp;"

# Import the SQL file into the newly created database
mysql -h ${RDS_ENDPOINT} -P 3306 -u admin -pcloudfyp cloud_fyp < /home/ec2-user/cloud_fyp.sql

# Verify the tables in the database
mysql -h ${RDS_ENDPOINT} -P 3306 -u admin -pcloudfyp -e "USE cloud_fyp; SHOW TABLES;"
