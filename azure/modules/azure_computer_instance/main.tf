resource "azurerm_linux_virtual_machine" "example" {
  # count               = var.number_of_instances
  # name                = "${count.index}-example-machine"
  name                = "${var.prefix_name}-machine"
  resource_group_name = var.resource_group.name
  location            = var.resource_group.location
  size                = "Standard_F2"
  admin_username      = var.username
  network_interface_ids = [
    # azurerm_network_interface.network_interface[count.index].id,
    var.network_interface_id
  ]

  admin_ssh_key {
    username   = var.username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  # provisioner "remote-exec" {
  #   inline = ["sudo apt update",
  #     "sudo apt install git docker.io -y",
  #     "curl https://gist.githubusercontent.com/kamuridesu/a3bd18849f2067efccec3140627cd9a8/raw/26b00ad996384dddee72e0ee13beec8d642ad332/api.py > api.py",
  #     "curl https://gist.githubusercontent.com/kamuridesu/a3bd18849f2067efccec3140627cd9a8/raw/26b00ad996384dddee72e0ee13beec8d642ad332/products.json > products.json",
  #     "curl https://gist.githubusercontent.com/kamuridesu/a3bd18849f2067efccec3140627cd9a8/raw/26b00ad996384dddee72e0ee13beec8d642ad332/requirements.txt > requirements.txt",
  #     "curl https://gist.githubusercontent.com/kamuridesu/a3bd18849f2067efccec3140627cd9a8/raw/26b00ad996384dddee72e0ee13beec8d642ad332/Dockerfile > Dockerfile",
  #     "sudo docker build -t api .",
  #     "sudo docker run -d --name api -p 5000:5000 api"
  #   ]
  #   on_failure = continue

  #   connection {
  #     type        = "ssh"
  #     user        = "adminuser"
  #     private_key = file("~/.ssh/id_rsa")
  #     # host        = azurerm_public_ip.public_ip[count.index].ip_address
  #     host = azurerm_public_ip.public_ip.ip_address
  #   }
  # }
}
