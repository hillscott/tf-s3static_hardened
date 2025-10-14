In-Progress...
--

Note that there are important files that you'll need to manually create per directions that will be posted here. These files are not tracked in the repository as they are installation specific. 

* backend.tf
* terraform.tfvars
* tf-s3static_hardened-init.sh
* tf-s3static_hardened-plan.sh
* tf-s3static_hardened-apply.sh


Additionally, there are some prep steps that must be taken in AWS prior to letting terraform take over. More docs coming on this...

Features that are coming soon:
* GuardDuty + SNS Notifications
* Auto IAM Policy generation for an S3 upload user
* CloudTrail / CloudWatch / SNS notifications for certain security events
