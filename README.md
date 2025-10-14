About
--
This repository is used to create a full AWS static web stack using terraform. Typical costs run ~$0.30-~$0.50USD/mo when using this stack.

Prep Work
--
More docs are coming, but at a high-level you will need to perform the following with ClickOps (via the graphical console):
* (Suggested) Create a fresh AWS Sub-Account via AWS Organizations
* (Suggested) Create and apply the provided IAM Role policy to your admin user in your root account (see the reference/ folder)
* (Suggested) Switch roles to the new account
* (Suggested) Create a new IAM admin user in that account
* Login to the IAM admin user
* Create an S3 Bucket for Terraform State named YOUR_DOMAIN-terraform
* Apply the S3 Bucket Policy provided (see the reference/ folder)
* Create a DynamoDB table named YOUR_DOMAIN-terraform-lock
    * Partition Key: LockID [String]

At that point you are ready to clone this repository, and create your local environment files. These files are installation specific, but there are examples available in the reference folder:

* backend.tf
* terraform.tfvars
* tf-s3static_hardened-init.sh
* tf-s3static_hardened-plan.sh
* tf-s3static_hardened-apply.sh


Features that are coming soon:
* GuardDuty + SNS Notifications
* Auto IAM Policy generation for an S3 upload user
* CloudTrail / CloudWatch / SNS notifications for certain security events
