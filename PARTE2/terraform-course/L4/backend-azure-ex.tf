terraform {
  backend "azurerm" {
    resource_group_name  = "tfresourcegroup"
    storage_account_name = "tfstorageaccount"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}    