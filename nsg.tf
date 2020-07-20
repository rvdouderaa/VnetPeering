
resource "azurerm_network_security_group" "example" {
  name                = "workload-nsg"
  location            = azurerm_resource_group.coreNetworking.location
  resource_group_name = azurerm_resource_group.coreNetworking.name


security_rule {
    name                       = "allowSubnetInbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "${var.ipSpace}/26"
    destination_address_prefix = "*"
  }


  security_rule {
    name                       = "allowRDP"
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefixes     = ["10.168.11.0/24","172.23.200.0/24","172.25.37.31","172.25.37.32","172.25.32.0/24"]
    destination_address_prefix = "*"
    description                = "Allow RDP inbound traffic"
  }
  security_rule {
    name                       = "allowUIM"
    priority                   = 151
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "48000-48025"
    source_address_prefixes    =  ["10.168.11.16/32","10.168.11.17/32","172.23.204.54/32","172.25.27.37/32"]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allowSystemCenter"
    priority                   = 152
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefixes    =  ["10.35.3.48/28","172.23.204.52/32","172.23.204.59/32","172.23.204.60/32","172.23.204.61/32"]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allowJumboMGMT"
    priority                   = 153
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefixes    =  ["172.23.200.0/24","172.25.37.31/32","172.25.37.32/32","172.25.27.246/32","172.23.204.54/32","172.25.27.37/32"]
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allowSimacMGMT"
    priority                   = 154
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["135","445","49125-65535"]
    source_address_prefix      = "10.168.11.0/24"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allowHTTPS"
    priority                   = 155
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


  security_rule {
    name                       = "allowHTTP"
    priority                   = 156
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  

  security_rule {
    name                       = "allowAzureLoadbalancer"
    priority                   = 401
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allowAzureStorage"
    priority                   = 402
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "Storage"
    destination_address_prefix = "*"

  }

  security_rule {
    name                       = "AllowICMP"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "ICMP"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "DenyAllInbound"
    priority                   = 500
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
      AppicationName = "Network"
  }

}