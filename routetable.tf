resource "azurerm_route_table" "example" {
    name                          = "${var.namingPrefix}-rt"
    location                      = azurerm_resource_group.coreNetworking.location
    resource_group_name           = azurerm_resource_group.coreNetworking.name
    disable_bgp_route_propagation = true

    route {
        name           = "default-to-NVA"
        address_prefix = "0.0.0.0/0"
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = "10.35.0.38"
    }

    route {
        name           = "to-jmb-infra-vn"
        address_prefix = "10.35.0.0/16"
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = "10.35.0.38"
    }

    route {
        name           = "to-workload-subnet"
        address_prefix = <workloadsubnet>
        next_hop_type  = "vnetlocal"
    }

    route {
        name           = "to-local-vn"
        address_prefix = <vnet address>
        next_hop_type  = "VirtualAppliance"
        next_hop_in_ip_address = "10.35.0.38"
    }

  tags = {
    ApplicationName = "Network"
  }
  
}