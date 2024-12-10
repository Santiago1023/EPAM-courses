/*
Avoid this:
account_number= "123456789012"
account_alias="mycompany"
region="us-east-2"
*/

# implement this:

# The attribute `${data.aws_caller_identity.current.account_id}` will be current account number.
data "aws_caller_identity" "current" {}

# The attribue `${data.aws_iam_account_alias.current.account_alias}` will be current account alias
data "aws_iam_account_alias" "current" {}

# The attribute `${data.aws_region.current.name}` will be current region
data "aws_region" "current" {}

# Set as local values
locals {
  account_id    = data.aws_caller_identity.current.account_id
  account_alias = data.aws_iam_account_alias.current.account_alias
  region        = data.aws_region.current.name
}