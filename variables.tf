variable "domain_name" {
  type        = string
  description = "The domain name for the website."
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket - basically domain_name."
}

variable "common_tags" {
  description = "AWS tags you want applied to all components."
}

variable "alerts_email" {
  description = "Where alerts regarding unusual actions in your AWS account should go."
}
