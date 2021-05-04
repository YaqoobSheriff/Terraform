provider "azurerm" {
  version = "~>2.0"
    features {}
	#Add your user principal values
	subscription_id = "****************************"
	client_id       = "****************************"
	client_secret   = "****************************"
	tenant_id       = "****************************"

}

resource "azurerm_resource_group" "group1" {
  name     = "testazxcf"
  location = "South India"
}

resource "azurerm_virtual_network" "network1" {
  name                = "azxcf-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.group1.location
  resource_group_name = azurerm_resource_group.group1.name
}

resource "azurerm_subnet" "subnet1" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.group1.name
  virtual_network_name = azurerm_virtual_network.network1.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "publicip1" {
    name                         = "azxcfIP"
    location                     = azurerm_resource_group.group1.location
    resource_group_name          = azurerm_resource_group.group1.name
    allocation_method            = "Dynamic"
}

resource "azurerm_network_security_group" "myterraformnsg" {
    name                = "azxcfGroup"
    location            = azurerm_resource_group.group1.location
    resource_group_name = azurerm_resource_group.group1.name

    security_rule {
        name                       = "RDP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "3389"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

resource "azurerm_network_interface" "interface1" {
  name                = "azxcf-nic"
  location            = azurerm_resource_group.group1.location
  resource_group_name = azurerm_resource_group.group1.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
	public_ip_address_id          = azurerm_public_ip.publicip1.id
  }
}

resource "azurerm_windows_virtual_machine" "vm1" {
  name                = "azxcf1"
  resource_group_name = azurerm_resource_group.group1.name
  location            = azurerm_resource_group.group1.location
  size                = "Standard_A2"
  admin_username      = "adminuser"
  admin_password      = "p@$$word123"
  network_interface_ids = [
    azurerm_network_interface.interface1.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
}