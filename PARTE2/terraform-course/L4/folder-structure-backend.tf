'''
the folder structure for the remote backend might look something like:

terraformstate
--development
  --elasticbeanstalk.tfstate
  --rds.tfstate
  --vpc.tfstate
--staging
  --elasticbeanstalk.tfstate
  --rds.tfstate
  --vpc.tfstate
--production
  --elasticbeanstalk.tfstate
  --rds.tfstate
  --vpc.tfstate
'''
# Here's the configuration for an Amazon Elastic Beanstalk application in the development environment:

terraform {
  backend "s3" {
    bucket         = "terraform-state-bucket"
    key            = "development/elasticbeanstalk.tfstate"
    region         = "us-east-1"
    encrypt        = true
}
