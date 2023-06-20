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

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.100.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "KN_04"
  }
}

resource "aws_security_group" "webserver" {
  name        = "webserver_sg"
  description = "Security group for webserver"
  vpc_id      = aws_vpc.main.id

  ingress {
    description      = "webserver"
    from_port        = 3306
    to_port          = 3306
    protocol         = "-1"
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
    Name = "webserver_sg"
  }
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

resource "aws_instance" "webserver" {
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
  - curl 
  - wget
  - apache2
  - php
  - libapache2-mod-php
  - php-mysqli
  - adminer
write_files:
  - encoding: b64
    path: /var/www/html/db.php
    content: PD9waHAKICAgICAgICAvL2RhdGFiYXNlCiAgICAgICAgJHNlcnZlcm5hbWUgPSAiMTcyLjMxLjEwMC4xNDkiOwogICAgICAgICR1c2VybmFtZSA9ICJhZG1pbiI7CiAgICAgICAgJHBhc3N3b3JkID0gInBhc3N3b3JkIjsKICAgICAgICAkZGJuYW1lID0gIm15c3FsIjsKCiAgICAgICAgLy8gQ3JlYXRlIGNvbm5lY3Rpb24KICAgICAgICAkY29ubiA9IG5ldyBteXNxbGkoJHNlcnZlcm5hbWUsICR1c2VybmFtZSwgJHBhc3N3b3JkLCAkZGJuYW1lKTsKICAgICAgICAvLyBDaGVjayBjb25uZWN0aW9uCiAgICAgICAgaWYgKCRjb25uLT5jb25uZWN0X2Vycm9yKSB7CiAgICAgICAgICAgICAgICBkaWUoIkNvbm5lY3Rpb24gZmFpbGVkOiAiIC4gJGNvbm4tPmNvbm5lY3RfZXJyb3IpOwogICAgICAgIH0KCiAgICAgICAgJHNxbCA9ICJzZWxlY3QgSG9zdCwgVXNlciBmcm9tIG15c3FsLnVzZXI7IjsKICAgICAgICAkcmVzdWx0ID0gJGNvbm4tPnF1ZXJ5KCRzcWwpOwogICAgICAgIHdoaWxlKCRyb3cgPSAkcmVzdWx0LT5mZXRjaF9hc3NvYygpKXsKICAgICAgICAgICAgICAgIGVjaG8oJHJvd1siSG9zdCJdIC4gIiAvICIgLiAkcm93WyJVc2VyIl0gLiAiPGJyIC8+Iik7CiAgICAgICAgfQogICAgICAgIC8vdmFyX2R1bXAoJHJlc3VsdCk7Cj8+
  - encoding: b64
    path: /var/www/html/info.php
    content: PD9waHAKCi8vIFNob3cgYWxsIGluZm9ybWF0aW9uLCBkZWZhdWx0cyB0byBJTkZPX0FMTApwaHBpbmZvKCk7Cgo/Pg==
runcmd:
  - sudo a2enconf adminer
  - sudo systemctl restart apache2

EOF

  tags = {
    Name = "webserver"
  }
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

resource "aws_network_interface" "database" {
  subnet_id   = aws_subnet.main.id
  private_ips = ["10.0.100.10"]
}

resource "aws_network_interface" "webserver" {
  subnet_id   = aws_subnet.main.id
  private_ips = ["10.0.100.11"]
}

resource "aws_eip" "database" {
  instance                  = aws_instance.database.id
  network_interface         = aws_network_interface.database.id
  associate_with_private_ip = "10.0.100.10"
}

resource "aws_eip" "webserver" {
  instance                  = aws_instance.webserver.id
  network_interface         = aws_network_interface.webserver.id
  associate_with_private_ip = "10.0.100.11"
}