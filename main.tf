terraform {
  backend "s3" {
    encrypt        = true
    key            = "ae-terraform-wireguard/terraform.tfstate"
    region         = var.aws-region
    dynamodb_table = "terraform-state-lock-dynamo"
  }
}

provider "aws" {
  region = var.aws-region
}

resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = "wireguard-terraform-state-lock-dynamo"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "DynamoDB Terraform State Lock Table"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

module "vpc" {
  source             = "./vpc"
  name               = var.name
  cidr               = var.cidr
  private_subnets    = var.private_subnets
  public_subnets     = var.public_subnets
  availability_zones = var.availability_zones
 
}