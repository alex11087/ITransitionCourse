provider "aws" {
  region = "us-east-2"
}

data "aws_availability_zones" "avilable" {}
data "aws_vpc" "default" {
  tags = {
    Name = "default"
  }
}
data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

output "default_vpc" {
  value = data.aws_vpc.default.id
}


#---------------------------------------------------------------------#

resource "aws_instance" "my_webserver" {
  ami                    = "ami-04d9716692b63512d"
  instance_type          = "t2.micro"
  key_name               = "k-pair"
  vpc_security_group_ids = [aws_security_group.itr-web-sg.id]

  tags = {
    Name = "ITR-CourseProject-Instance"
  }
}

#---------------------------------------------------------------------#

resource "aws_security_group" "itr-web-sg" {
  name        = "WebServer Security Group"
  description = "My Security Group for ITR course project"

  dynamic "ingress" {
    for_each = ["22", "80", "8000", "3306"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "Dynamic SG"
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
module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "ITR-ALB"

  load_balancer_type = "application"

  vpc_id          = data.aws_vpc.default.id
  subnets         = data.aws_subnet_ids.all.ids
  security_groups = [aws_security_group.itr-web-sg.id]


  target_groups = [
    {
      name_prefix      = "pref-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      targets = [
        {
          target_id = aws_instance.my_webserver.id
          port      = 80
        },
        {
          target_id = aws_instance.my_webserver.id
          port      = 8000
        }
      ]
    }
  ]


  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    },
    {
      port               = 8000
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "ITR-CourseProject"
  }
}
#---------------------------------------------------------------------#
