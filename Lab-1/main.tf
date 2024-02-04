provider "aws" {
  region     = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

resource "aws_security_group" "security-group-1" {
  name = "terraform-test-sg"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "my_ec2_instance" {
  ami                    = var.AWS_AMIS[var.AWS_REGION]
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.security-group-1.id]
  user_data              = <<-EOF
		#!/bin/bash
        yum update -y
        yum install -y httpd
        systemctl start httpd
        systemctl enable httpd
        echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
	EOF
  tags = {
    Name = "terraform test"
  }
  provisioner "local-exec" {
    command = "echo EC2 Adress : ${self.public_ip}"
  }
}



