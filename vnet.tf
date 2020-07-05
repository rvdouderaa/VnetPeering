

/*
resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.APIM.id
  network_security_group_id = azurerm_network_security_group.example.id
  provider = azurerm.prod
}
*/resource "azurerm_resource_group" "coreNetworking" {
    name      = "core-networking-we-rg"
    location  = "westeurope" 
    tags = local.common_tags
}


resource "azurerm_virtual_network" "example" {
  name                = "testvn-vn"
  location            = azurerm_resource_group.coreNetworking.location
  resource_group_name = azurerm_resource_group.coreNetworking.name
  address_space       = ["10.192.0.0/24"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
  
  tags = local.common_tags
}

### Virtual Network Peering ###
resource "azurerm_virtual_network_peering" "virtualnetwork" {
  name                      = "peerlocal"
  resource_group_name       = azurerm_resource_group.coreNetworking.name
  virtual_network_name      = azurerm_virtual_network.example.name
  remote_virtual_network_id = "/subscriptions/bf706a6f-4710-459b-bb7b-22ca2ffb50c1/resourceGroups/core-networking-infra-we-rg/providers/Microsoft.Network/virtualNetworks/jmb-infra-vn"
}

resource "azurerm_virtual_network_peering" "infrastructure-vn" {
  name                      = "infra-vn"
  resource_group_name       = "core-networking-infra-we-rg"
  virtual_network_name      = "jmb-infra-vn"
  remote_virtual_network_id = azurerm_virtual_network.example.id
  provider = azurerm.infrastructure
}

