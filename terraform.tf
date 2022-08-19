terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.27.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region     = var.region
  access_key = "AKIA2IZ3JRKKV3HEGA2C"
  secret_key = "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"

}
resource "aws_security_group" "security_groups_vm1" {
  name = "aws_secgroup_VM1"

  tags = { "name" = "web_security_group_vm1" }
  ingress {

    from_port = 80

    protocol    = "TCP"
    cidr_blocks = var.cidr_block
    to_port     = 80
  }

  ingress {

    from_port = 443

    protocol    = "TCP"
    cidr_blocks = var.cidr_block
    to_port     = 443
  }
  ingress {

    from_port = 22

    protocol    = "TCP"
    cidr_blocks = var.cidr_block
    to_port     = 22
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_block
  }

}

resource "aws_security_group" "security_groups_vm2" {
  name = "aws_secgroup_VM2"

  tags = { "name" = "web_security_group_vm2" }
  ingress {

    from_port   = 8
    protocol    = "icmp"
    cidr_blocks = var.cidr_block
    to_port     = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr_block
  }

}

resource "aws_instance" "web_server_VM1" {
  #ami             = data.aws_ami.ami_data.id
  ami             = var.aws_ami
  instance_type   = var.instance_type
  vpc_security_group_ids = [aws_security_group.security_groups_vm1.id]
  user_data       = file("${path.cwd}/installation_nginx.sh")
  #user_data       = file("${path.module}/script.sh")
  tags = {
    "name" = "web_server_VM1"
  }
}

resource "aws_instance" "ping_server_VM2" {
  #ami             = data.aws_ami.ami_data.id
  ami             = var.aws_ami
  instance_type   = var.instance_type
  vpc_security_group_ids = [aws_security_group.security_groups_vm2.id]
  #user_data       = file("${path.cwd}/installation_nginx.sh")
  #user_data       = file("${path.module}/script.sh")
  tags = {
    "name" = "ping_server_VM2"
  }
}
