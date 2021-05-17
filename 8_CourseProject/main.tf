provider "aws" {
  region = "us-east-2"
}

data "aws_availability_zones" "available" {}

#---------------------------------------------------------------------#

resource "aws_instance" "my_webserver" {
  ami                    = "ami-04d9716692b63512d"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.web-sg.id]

  tags = {
    Name = "ITR-CourseProject"
  }
}

#---------------------------------------------------------------------#

resource "aws_security_group" "web-sg" {
  name        = "WebServer Security Group"
  description = "My Security Group for ITR course project"

  dynamic "ingress" {
    for_each = ["80", "443"]
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
resource "aws_key_pair" "deployer" {
  key_name   = "d-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8B1UvrtT6BbrU9W8ZLJN3MrzpqqAopbBz+nLF/GfIgb1gSuUZX9CbXErQe93F57lF0gUqzX+a0M308fI0UGV6FPjIUNjnSBWk7ZlX6tA2t5pDn6nenlEpzUqg73u2q1/Sn4YKeLvji0v6WQcR/T9x//+f1/I0hGZpHNfUJwFp3VDdq1n6UEO4KkDn5LllevAW7aC+UMgy1NqOjot/wzr19rCf+/I6H4ucwmidcDhI1TW9wxi4E0piDVZGeojJeM6oi4/iJYtD83ewJPRDuQU8FlEuVDaRAUINVTzC2HGbTICltFGYFTkF2s20lKaAalmbCX4k91L45LJ8W60IZ7pf5ca22bImCD8YV8iDbfJXAthU1fwwC++HRWVVM+daVf7mLNBnSoFcN8HGqqZ5M/BaXRWoTotGgxVe7qZ+/m4DiYnmMfMvf0XqLq0pRS9k4PQOeKDpa3mZi2IGjJVJzDtUTJb1PNTc233UNV0lt1j8ZVqGT3Kr+M4ZC6v/oVRO0d0= alex@alex-Aspire-E1-571G"
}


#---------------------------------------------------------------------#

resource "aws_elb" "web-elb" {
  name               = "ITR-LoadBalancer"
  availability_zones = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  security_groups    = [aws_security_group.web-sg.id]
  listener {
    lb_port           = 80
    lb_protocol       = "http"
    instance_port     = 80
    instance_protocol = "http"
  }
  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 6
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 10
  }
  tags = {
    Name = "ITR-WebServer"
  }
}
