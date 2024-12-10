terraform {
  backend "s3" {
    encrypt = true
  }
}


/*
After you set backend-dev.conf and dev.tfvars properly (for each environment),
execute the following commands step by step:

terraform get -update=true
terraform init -backend-config=config/backend-${env}.conf
terraform plan -var-file=config/${env}.tfvars
terraform apply -var-file=config/${env}.tfvars
*/