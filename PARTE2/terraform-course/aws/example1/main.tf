terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-west-2"
}

# Resource blocks have two strings before the block: the resource type and the resource name
resource "aws_instance" "app_server" {
#   ami           = "ami-830c94e3"
  ami           = "ami-08d70e59c07c61a3a"
  instance_type = "t2.micro"

  tags = {
    # Name = "ExampleAppServerInstance"
    Name = var.instance_name
  }
}

# Para agregarle una vpc y una subnet 
#  resource "aws_instance" "app_server" {
#    ami                    = "ami-830c94e3"
#    instance_type          = "t2.micro"
#    vpc_security_group_ids = ["sg-0077..."]
#    subnet_id              = "subnet-923a..."
#  }