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

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

data "aws_ssm_parameter" "amazon_linux_2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "cloudpilot_demo" {
  ami           = data.aws_ssm_parameter.amazon_linux_2023.value
  instance_type = "t3.small"

  subnet_id = data.aws_subnets.default.ids[0]

  tags = {
    Name        = "CloudPilot-Demo"
    Environment = "development"
    Owner       = "CloudPilot"
  }
}