#!/bin/bash
set -e  # stop on first error
BUCKET=calculator-first-cicd-458284369197
 
# Upload all child templates
echo "Using bucket: $BUCKET"

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
  

aws cloudformation wait stack-update-complete \
  --stack-name main-stack


WS_URL=$(aws cloudformation describe-stacks \
 --stack-name main-stack \
 --query "Stacks[0].Outputs[?OutputKey=='WebSocketUrl'].OutputValue" \
 --output text)
 echo "WebSocket URL from CloudFormation: $WS_URL"

# Replace placeholder in index.html locally
sed -i "s|wss://<api-id>.execute-api.<region>.amazonaws.com/dev|$WS_URL|g" frontend/index.html

aws s3 cp frontend/index.html s3://calculator-static-frontend-file-458284369197/index.html