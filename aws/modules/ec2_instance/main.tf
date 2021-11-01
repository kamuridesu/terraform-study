resource "aws_key_pair" "ssh_key" {
  key_name = "ssh_key"
  public_key = var.public_key
}

resource "aws_security_group" "ec2_security_ports" {
  name = "${var.counter}_ec2_security_ports"
  
  dynamic "ingress" {
    for_each = var.vm_connetion_ports
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.counter}_ec2_security_ports"}
}

resource "aws_instance" "api" {
  ami           = "ami-07d02ee1eeb0c996c"
  key_name = aws_key_pair.ssh_key.key_name
  instance_type = "t2.micro"
  security_groups = [ aws_security_group.ec2_security_ports.name ]

  tags = {
    Name = "${var.counter}-API"
  }

  provisioner "remote-exec" {
    inline = ["sudo apt update",
      "sudo apt install git ca-certificates curl gnupg lsb-release apt-transport-https -y",
      "curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo apt-get update",
      "sudo apt-get install docker-ce docker-ce-cli containerd.io -y",
      "curl https://gist.githubusercontent.com/kamuridesu/a3bd18849f2067efccec3140627cd9a8/raw/26b00ad996384dddee72e0ee13beec8d642ad332/api.py > api.py",
      "curl https://gist.githubusercontent.com/kamuridesu/a3bd18849f2067efccec3140627cd9a8/raw/26b00ad996384dddee72e0ee13beec8d642ad332/products.json > products.json",
      "curl https://gist.githubusercontent.com/kamuridesu/a3bd18849f2067efccec3140627cd9a8/raw/26b00ad996384dddee72e0ee13beec8d642ad332/requirements.txt > requirements.txt",
      "curl https://gist.githubusercontent.com/kamuridesu/a3bd18849f2067efccec3140627cd9a8/raw/26b00ad996384dddee72e0ee13beec8d642ad332/Dockerfile > Dockerfile",
      "sudo docker build -t api .",
      "sudo docker run -d --name api -p 5000:5000 api"
    ]
    on_failure = fail

    connection {
      type        = "ssh"
      user        = var.username
      private_key = var.private_key
      host        = self.public_ip
    }
  }
}