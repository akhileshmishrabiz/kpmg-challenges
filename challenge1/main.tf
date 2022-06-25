terraform {
  backend "s3" {
    bucket         = "akhileshmishrabiz-tfstate"
    key            = "recipe-app.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "akhileshmishrabiz-tfstate-lock"
  }
}

provider "aws" {
  region = "ap-south-1"

}

locals {
  prefix = var.prefix
  common_tags = {
    Environment = terraform.workspace
    Project     = var.project
    Contact     = var.contact
    Managed_by  = "Terraform"
  }
}

## 

data "aws_region" "current" {

}

