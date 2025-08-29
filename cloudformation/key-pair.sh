aws ec2 create-key-pair \
  --key-name calculator-key-pair \
  --query "KeyMaterial" \
  --output text > calculator-key-pair.pem