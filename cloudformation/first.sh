#!/bin/bash

BUCKET=calculator-first-cicd-bucket
 
# Upload all child templates

for file in roles.yml codebuild.yml lambda-deploy.yml pipeline.yml; do

  aws s3 cp $file s3://$BUCKET/$file

done
 
#Now deploy the main stack

# aws cloudformation create-stack \
#   --stack-name main-stack \
#   --template-body file://main.yml \
#   --capabilities CAPABILITY_NAMED_IAM

aws cloudformation update-stack \
  --stack-name main-stack \
  --template-body file://main.yml \
  --capabilities CAPABILITY_NAMED_IAM