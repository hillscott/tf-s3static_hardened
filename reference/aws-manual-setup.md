To Configure Manually in AWS (High Level)
--
* Start with a fresh AWS Sub-Account via AWS Organizations
* Create and apply the provided IAM Role policy to your admin user in your root account
* Switch roles to the new account
* Create a new IAM admin user in that account
* Create an S3 Bucket for Terraform State named YOUR_DOMAIN-terraform
* Apply the S3 Bucket Policy provided in references

To Create Locally
--
* terraform.tfvars
* tf-s3static_hardened-init.sh
* (Optional) tf-s3static_hardened-plan.sh
* (Optional) tf-s3static_hardened-apply.sh
