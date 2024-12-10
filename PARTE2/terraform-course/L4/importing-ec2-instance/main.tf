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

# terraform init  (initialize the terraform project)

resource "aws_instance" "tf_import_example" {
  ami           = "unknown"
  instance_type = "unknown"
}

# we import the EC2 data that already is created in AWS, it brings the data to the terraform state
# terraform import aws_instance.tf_import_example <YOUR_AWS_INSTANCE_ID>
# terraform import aws_instance.tf_import_example i-0ede37b5bbc0bf0ff 

# then, with terraform plan, you can see the discrepances between the configuration and state files