# Terraform setup
export TF_LOG="error"
export TF_LOG_PATH="[home-dir]/terraform-data/tf-s3static_hardened/tf-log.txt"
export TF_DATA_DIR="[home-dir]/terraform-data/tf-s3static_hardened/tf-state"
# If you are using a separate AWS configured profile
export AWS_PROFILE="[profile-name]"
export AWS_REGION="[AWS-Region-Code]"
# Copy this script and then you can make minor adjustments to allow for init
# apply, destroy, etc
terraform plan
