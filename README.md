About
--
This repository is used to create a full AWS static web stack using terraform. Typical costs run around $1.00USD/mo (depending on usage) when using this stack.

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

At that point you are ready to either:
1. Clone this repository to your development host, and create your local environment files. These files are installation specific, but there are examples available in the reference folder:
* terraform.tfvars
* tf-s3static_hardened-init.sh (this will build the necessary backend.conf and call it)
* (Optional) tf-s3static_hardened-plan.sh
* (Optional) tf-s3static_hardened-apply.sh

If you don't want to create the tf-static_hardened-apply.sh (or plan), you will still need your environment variables to contain AWS_REGION at a minimum. It is assumed that you have already gone through and configured AWS credentials with `aws configure`

**OR**

2. (Advanced) Use GitHub Actions (or another CI/CD pipeline). An example GitHub Action file is available here: [plan-template](./reference/EXAMPLE-github_actions-terraform-plan.yml) and [apply-template](./reference/EXAMPLE-github_actions-terraform-apply.yml)

If you use GitHub Actions, you don't need a host to deploy your infrastructure at all. There are _many_ ways to do this, but one fairly simple one follows...: 
* Mirror this repository into an empty **private** one that you control
* Add your AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY into GitHub -> Settings -> Secrets and Variables -> Actions -> Repository secrets
* Create a new file in your mirrored repository .github/workflows/terraform-plan.yml and populate it from the plan-template referenced above
* Make another file .github/workflows/terraform-action.yml and populate it from the action-template referenced above
* Modify the domains in these files to match your needs (and commit these changed files)
* You should now be able to navigate to Actions in your GitHub repository and trigger the plan or apply actions (and monitor their progress) from GitHub

You _can_ modify the GitHub templates to trigger on commit obviously (the main point to CI/CD), but I will leave that to you. Tread carefully. 

Features that are coming soon:
--
* Auto IAM Policy generation for an S3 upload user
* CloudTrail / CloudWatch / SNS notifications for certain security events
* Conversion to a module
