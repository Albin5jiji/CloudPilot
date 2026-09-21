terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "cloudpilot_demo" {
  ami           = "ami-06cfeaaa22092f09d"
  instance_type = "t3.small"
  subnet_id     = "subnet-0a7a1728a66d078a1"

  tags = {
    Name        = "CloudPilot-Demo"
    Environment = "development"
    Owner       = "CloudPilot"
  }
}
