terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
  # Terraform S3-based state locking introduced in 1.11.0
  required_version = ">= 1.11.0"
}

provider "aws" {
  alias  = "acm_provider"
  region = "us-east-1"
}
