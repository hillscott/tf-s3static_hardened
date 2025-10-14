About
--
This repository is used to create a full AWS static web stack using terraform. Typical costs run around $0.50USD/mo when using this stack.

It Deploys a suite of AWS Services to provide you a secure hosting environment. These services include:
* **Route53** (for DNS hosting of your domain)
* **S3** (with no public access thanks to OAC - Origin Access Control and IAM Policies)
* **ACM** (for encryption in-transit to viewers)
* **Cloudfront** (which includes network level DDOS protection w/ AWS Shield and TLS 1.2 requirements)
* **GuardDuty** (to secure your AWS account from unusual backend access attempts)
* **SNS** (to alert you via email - should GuardDuty see something unusual)

Prep Work
--
More docs are coming, but at a high-level you will need to perform the following with ClickOps (via the graphical console) BEFORE running this stack:
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
* (Optional) tf-s3static_hardened-init.sh
* (Optional) tf-s3static_hardened-plan.sh
* (Optional) tf-s3static_hardened-apply.sh

If you don't want to create the tf-static_hardened-apply.sh, you will still need your environment variables to contain AWS_REGION at a minimum. It is assumed that you have already gone through and configured AWS credentials with `aws configure`

Features that are coming soon:
* Auto IAM Policy generation for an S3 upload user
* CloudTrail / CloudWatch / SNS notifications for certain security events
