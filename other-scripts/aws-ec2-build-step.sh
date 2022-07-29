#!/usr/bin/env bash
# Author: Abhijit Wakchaure <awakchau@tibco.com>

# arg1: error message
# [arg2]: exit code
function exit_with_error {
    printf '\n%s\n' "$1" >&2 ## Send message to stderr.
    exit "${2-1}" ## Return a code specified by $2, or 1 by default.
}

export AWS_PAGER=""
export ROLE_SESSION_NAME="via-tc-job"
export AWS_ACCESS_KEY_ID=$QA_AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=$QA_AWS_SECRET_ACCESS_KEY

if [ -z "$EC2_MYSQL_SSL_INSTANCE_ID" ]; then
    exit_with_error "Env var EC2_MYSQL_SSL_INSTANCE_ID is not defined!"
fi

if ! [ -x "$(command -v aws)" ]; then
  echo 'AWS CLI is not installed...installing aws cli now'
  curl -s "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
  unzip -qq awscliv2.zip
  ./aws/install
  which aws
  aws --version
fi

if ! [ -x "$(command -v jq)" ]; then
  echo 'jq is not installed...installing jq now'
  yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
  yum install jq -y
fi

aws sts get-caller-identity

eval $(aws sts assume-role --role-arn $ROLE_ARN --role-session-name $ROLE_SESSION_NAME | jq -r '.Credentials | "export AWS_ACCESS_KEY_ID=\(.AccessKeyId)\nexport AWS_SECRET_ACCESS_KEY=\(.SecretAccessKey)\nexport AWS_SESSION_TOKEN=\(.SessionToken)\n"')

echo "Starting EC2 instance with instance ID $EC2_MYSQL_SSL_INSTANCE_ID"
aws ec2 start-instances --instance-ids $EC2_MYSQL_SSL_INSTANCE_ID

echo "Waiting for EC2 instance with instance ID $EC2_MYSQL_SSL_INSTANCE_ID to start"
aws ec2 wait instance-running --instance-ids $EC2_MYSQL_SSL_INSTANCE_ID

EC2_PUBLIC_DNS=$(aws ec2 describe-instances --instance-ids $EC2_MYSQL_SSL_INSTANCE_ID --filters Name=instance-state-name,Values=running | jq -r '.Reservations|.[0].Instances|.[0].PublicDnsName')

if [ -z "$EC2_PUBLIC_DNS" ]; then
    exit_with_error "Failed to get EC2 public DNS!"
fi

echo "Found EC2 public DNS as $EC2_PUBLIC_DNS"

echo "Connector host before: $EC2_PUBLIC_DNS"

echo "##teamcity[setParameter name='env.CONNECTOR_HOST' value='$EC2_PUBLIC_DNS']"

echo "Connector host after: $EC2_PUBLIC_DNS"