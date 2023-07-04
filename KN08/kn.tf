terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_security_group" "database" {
  name        = "database_sg"
  description = "Security group for database"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "database"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [aws_subnet.main.cidr_block]
    ipv6_cidr_blocks = [aws_subnet.main.ipv6_cidr_block]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "database_sg"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "database" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.main.id

  user_data = <<EOF
#cloud-config
users:
  - name: ubuntu
    sudo: ALL=(ALL) NOPASSWD:ALL
    groups: users, admin
    home: /home/ubuntu
    shell: /bin/bash
    ssh_authorized_keys:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCibIsaqY7lwA3ZxLaFUT1/UroxYK35ptCX2+pinj1jS9d60KuqiSWM2JmvwgijB3Wt7HhL2TfH6KdQAeNK1EIcUaxowkyVJlwk35cr9DVEY5MH3te/rrZNyC4hUlvcwL/Ik2zFcVV5D9/J9ZlKWI/MKUY5shSmwz6VPHdO+Ucfdlj8eLySYajlYXSE8ygml0tCO36c7p+WHfymKVWxMMhBTJ9QVFxzse/9GUy12hNHDqRWyA84GfXaLDJTOSsPZb7skm5dS9FAESbyg+vRsVPx6pCLrCYkG4pYzUg7HnzuAUFOAqPeX/oZRH3a1VsXrv+ydg7EE2PJ4hg23VyUK/E9 aws-key       
ssh_pwauth: false
disable_root: false
package_update: true
packages:
  - mariadb-server
runcmd:
  - sudo mysql -sfu root -e "GRANT ALL ON *.* TO 'admin'@'%' IDENTIFIED BY'password' WITH GRANT OPTION;"
  - sudo sed-i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
  - sudo systemctl restart mariadb.service

EOF

  tags = {
    Name = "database"
  }
}