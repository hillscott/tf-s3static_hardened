# Terraform setup
# Keep modules out of our git directory...
export TF_DATA_DIR="[home-dir]/terraform-data/tf-s3static_hardened/tf-state"
# If you are using a separate AWS configured profile
export AWS_PROFILE="[profile-name]"
export AWS_REGION="[AWS-Region-Code]"
# backend.tf doesn't allow for variables... work around this below
export TF_STATE_bucket_name="[YOUR-DOMAIN-HERE]-terraform"
export TF_STATE_key="prod/terraform.tfstate"
export TF_STATE_dynamodb_table="[YOUR-DOMAIN-HERE]-terraform-lock"
cat << BACKEND >backend.conf
    bucket         = "$TF_STATE_bucket_name"
    key            = "$TF_STATE_key"
    dynamodb_table = "$TF_STATE_dynamodb_table"
BACKEND
# Copy this script and then you can make minor adjustments to allow for init
# apply, destroy, etc
terraform init -backend-config=backend.conf
