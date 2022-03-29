terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

#Configure the AWS provider
provider "aws" {
  region = "us-east-1"
  # version not needed here
}

resource "aws_default_vpc" "default" {
}

# Create a security group
resource "aws_security_group" "capstone_sg" {
  name   = "capstone_sg"
  vpc_id = aws_default_vpc.default.id

  dynamic "ingress" {
    iterator = port
    for_each = var.ingress_rules
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = [aws_default_vpc.default.cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    name = "capstone_sg"
  }
}


resource "aws_instance" "capstone_server" {
  ami                    = data.aws_ami.ubuntu.id
  key_name               = var.aws_key_name
  instance_type          = count.index == 0 ? "t2.medium" : var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.capstone_sg.id]
  subnet_id              = tolist(data.aws_subnet_ids.default_subnets.ids)[2]
  count                  = var.instance_count
  user_data              = count.index == 0 ? file("install-k8s-master.sh") : file("install-k8s-worker.sh")
  tags = {
    Name = "${count.index == 0 ? var.master : join("-", [var.worker, count.index])}"
  }
}
