#!/bin/bash

###############################################
# Author: Kajal
# Date: 5th May, 2024
#
# Version: v1
#
# This script will report the AWS resource usage
#
###############################################


# it will print the command is used
set -x

# Resources we are tracking
# AWS S3
# AWS EC2
# AWS Lambda
# AWS IAM

# List S3 buckets
echo "Print S3 Bucket"
aws s3 ls

# List EC2 Instances
echo "Print EC2 instances"
#aws ec2 describe-instances
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'

# List Lambda Functions
echo "Print Lambda function"
aws lambda list-functions

# List IAM users
echo "Print IAM Users"
aws iam list-users


################################################
# END 
################################################
