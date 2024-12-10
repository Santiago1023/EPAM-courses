terraform {        
    required_version = "1.0.0"        
    required_providers {            
        aws = {                
            version = ">= 3.2.0"                
            source = "hashicorp/aws"            
        }        
    }        
    backend "s3" {            
        region  = "us-east-1"            
        dynamodb_table = "terraform-lock-state"            
        bucket  = "remote-state-bucket"            
        key  = "states/state.tfstate"            
        encrypt = true        
    }   
}