terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "tf_import_example" {
  ami           = "ami-0d887a308369b6881"
  instance_type = "t3.micro"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.medium"

  validation {
   condition     = can(regex("^[Tt][3].(micro|small)", var.instance_type))
   error_message = "Invalid Instance Type name. You can only choose - t3.micro,t3.small"
 }
}

/*
The task is to restrict the provisioning of the EC2 instance to t3.micro, and t3.small.
You should provide appropriate error messages if a developer attempts to provision a t3.medium or any higher instance.
*/