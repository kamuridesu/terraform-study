resource "azurerm_public_ip" "public_ip" {
  # count = var.number_of_instances
  # name                = "${count.index}-public_ip_instance"
  name                = "${var.prefix_name}-public-ip"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  allocation_method   = var.public_ip_allocation_method
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.prefix_name}-network"
  address_space       = ["10.0.0.0/16"]
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix_name}-internal"
  resource_group_name  = var.resource_group.name
  virtual_network_name = azurerm_virtual_network.virtual_network.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "network_interface" {
  name                = "${var.prefix_name}-nic"
  location            = var.resource_group.location
  resource_group_name = var.resource_group.name

  ip_configuration {
    name                          = "${var.prefix_name}-internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}