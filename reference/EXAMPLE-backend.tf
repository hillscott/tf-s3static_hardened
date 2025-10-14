terraform {
  backend "s3" {
    bucket         = "[domain]-terraform"
    key            = "prod/terraform.tfstate"
    dynamodb_table = "[domain]-terraform-lock"
  }
}
