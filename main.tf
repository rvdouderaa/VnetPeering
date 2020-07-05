provider "azurerm" {  
  subscription_id = "edc38ff9-6a0b-4bec-9384-709deb3625c4"    
  client_id       = var.clientid
  client_secret   = var.clientsecret
  tenant_id       = var.tenantid
  features {}
}


provider "azurerm" {
  alias = "infrastructure"
  # Whilst version is optional, we /strongly recommend/ using it to pin the version of the Provider being used
  version = "=2.4.0"

  subscription_id = "bf706a6f-4710-459b-bb7b-22ca2ffb50c1"
  client_id       = var.clientid
  client_secret   = var.clientsecret
  tenant_id       = var.tenantid
    skip_provider_registration = true


  features {}
}


locals {
    common_tags = "${map(
        "ApplicationName", "WLAUT",
        "BIVClassification", "",
        "Description", "Azure Workload automation automated",
        "Environment", "Production",
        "TeamName", "ET",
        "Project_Change", "CE-164",
        "ServiceLevel", "",
        "TeamContactMail", "atanas.pumakchiev@jumbo.com",
        "TerraformManaged", "true"
    )}"
}

variable "tenantid"{
    type = string
}
variable "clientid"{
    type = string
}

variable "clientsecret"{
    type = string
}