provider "aws" {
  region = "us-east-2"
}

data "aws_availability_zones" "available" {}

data "aws_vpc" "default" {
  tags = {
    Name = "ITR-Network"
  }
}
/*
data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}
*/
output "default_vpc" {
  value = data.aws_vpc.default.id
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}


#---------------------------------------------------------------------#
# CREATE SUBNETS
#---------------------------------------------------------------------#
resource "aws_subnet" "aws_public_subnet1" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "10.0.11.0/24"
  //availability_zone = "us-east-2a"
  availability_zone = data.aws_availability_zones.available.names[0]


  tags = {
    Name = "ITR-Public-Subnet-1"
  }
}

resource "aws_subnet" "aws_public_subnet2" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "10.0.21.0/24"
  //availability_zone = "us-east-2b"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = {
    Name = "ITR-Public-Subnet-2"
  }
}

resource "aws_subnet" "aws_private_subnet1" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "10.0.12.0/24"
  //availability_zone = "us-east-2a"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = {
    Name = "ITR-Private-Subnet-1"
  }
}
#---------------------------------------------------------------------#
# CREATE INSTANCES
#---------------------------------------------------------------------#

resource "aws_instance" "aws_public_1" {
  ami                    = "ami-0b9064170e32bde34"
  instance_type          = "t2.micro"
  key_name               = "k-pair"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  subnet_id              = aws_subnet.aws_public_subnet1.id

  tags = {
    Name = "ITR-Public-1-Instance"
  }

  user_data = <<EOF
#!/bin/bash
sudo apt update
sudo apt install -y nginx
sudo echo "<html><body bgcolor=blue><center><h1><p><font color=red> Web Server 1</h1></center></body></html>" > /var/www/html/index.html
sudo service nginx restart
EOF

}

resource "aws_instance" "aws_public_2" {
  ami                    = "ami-0b9064170e32bde34"
  instance_type          = "t2.micro"
  key_name               = "k-pair"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  subnet_id              = aws_subnet.aws_public_subnet2.id

  tags = {
    Name = "ITR-Public-2-Instance"
  }

  user_data = <<EOF
#!/bin/bash
sudo apt update
sudo apt install -y nginx
sudo echo "<html><body bgcolor=red><center><h1><p><font color=blue> Web Server 2</h1></center></body></html>" > /var/www/html/index.html
sudo service nginx restart
EOF

}

resource "aws_instance" "aws_private_1" {
  ami                    = "ami-0b9064170e32bde34"
  instance_type          = "t2.micro"
  key_name               = "k-pair"
  vpc_security_group_ids = [aws_security_group.web-sg.id]
  subnet_id              = aws_subnet.aws_private_subnet1.id

  tags = {
    Name = "ITR-Private-1-Instance"
  }
}

#---------------------------------------------------------------------#
# CREATE SECURITY GROUP
#---------------------------------------------------------------------#

resource "aws_security_group" "web-sg" {
  description = "My Security Group for ITR course project"

  vpc_id = data.aws_vpc.default.id

  dynamic "ingress" {
    for_each = ["22", "80", "443", "8000"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Web-SG"
    Owner = "Alexey Bobrov"
  }

}

#---------------------------------------------------------------------#
/*
resource "aws_key_pair" "deployer" {
  key_name   = "d-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDTNmSQTrksVyFbIzHUnmpzoDMvV6nxSX093/SN3jVptMutgUlJPjX9IYrvdtbMXVJmdqG187eOv5Iyew0goO/kemv6Hhca0Nlpnr6GcGq7PA1zswCnMEDVyFLP3x1y6dGUXNqSiLirxuho2HfVZ7jGfN9deS4lQa7cNDg2y9ijD2cThRYHcbPZy9BvfumM2BRZxyCZS7CfNJO3pv1FsCKriIjDw519UYZc7rShYU4UtvQAp8y/myl4NUExtXfuJXYcDSfSsuEpikxvcuTao8YT8nFRCY4+4Kn++6uew6ekgLpfjryO+wUaJgSO9sLWDcI89BrNgt7/TK3suinhByiJ+1L+v4Dbxafk9qCoPKOFOidlMvqZC0wmGiYl3WmCF8DHmi1uxWkZLitOjwMESFRle6ehSwflDUUqpIT5vhjIXvNdT+jYU+6BZoPrnW26vLpTKlED17SYs0eDi0EqOh1G8CsQxjHUrFPDx2loPuYx2WkeqSS62Nf8oOKjx1Jt8gE= alex@alex-Aspire-E1-571G"
}
*/
#---------------------------------------------------------------------#
# CREATE APPLICATION LOAD BALACNER
#---------------------------------------------------------------------#

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "ITR-ALB-PROJECT"

  load_balancer_type = "application"

  vpc_id = data.aws_vpc.default.id
  subnets = [
    aws_subnet.aws_public_subnet1.id,
    aws_subnet.aws_public_subnet2.id
  ]
  security_groups = [aws_security_group.web-sg.id]


  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = [
        {
          target_id = aws_instance.aws_public_2.id
          port      = 80
        },
        {
          target_id = aws_instance.aws_public_1.id
          port      = 80
        }
      ]
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "ITR-CourseProject"
  }
}
#---------------------------------------------------------------------#


#---------------------------------------------------------------------#
