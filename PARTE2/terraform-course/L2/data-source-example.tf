# Using this data source you can find few attributes from your AWS account, for example    
# account_ID    
data "aws_caller_identity" "my_account" {}    

# Find route tables only from private Subnets.    
data "aws_route_tables" "private_usw2" {        
    vpc_id = my_vpc.vpc_id        
    filter {            
        name = "tag:Name"            
        values = ["route_private*"]        
    }    
}