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
  type        = string
  description = "Where alerts regarding unusual actions in your AWS account should go."
}

variable "price_class" {
  type        = string
  description = "CloudFront Distribution pricing class aka where your site will be cached."
  # PriceClass_100 is used for N America
  default = "PriceClass_100"
}
