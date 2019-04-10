#!/bin/bash

# Get the MFA-protected session details
output=$(aws sts get-session-token --serial-number arn:aws:iam::$1:mfa/$2 --query 'Credentials.[SecretAccessKey,AccessKeyId,SessionToken]' --output text --token-code $3)

# get the aws_secret_access_key
aws_secret_access_key=$(echo $output | cut -f1 -d ' ')

# get the aws_secret_access_key
aws_access_key_id=$(echo $output | cut -f2 -d ' ')

# get the aws_secret_access_key
aws_session_token=$(echo $output | cut -f3 -d ' ')

`aws configure set profile.mfa.region eu-west-1`
`aws configure set profile.mfa.aws_access_key_id $aws_access_key_id`
`aws configure set profile.mfa.aws_secret_access_key $aws_secret_access_key`
`aws configure set profile.mfa.aws_session_token $aws_session_token`

echo "mfa profile updated with MFA-protected temporary credentials"
