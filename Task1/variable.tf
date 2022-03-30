variable "aws_key_pair" {
  default = "us-east-kp.pem"
}

variable "aws_key_name" {
  default = "us-east-kp"
}

variable "ec2_instance_type" {
  default = "t2.micro"
}

variable "ingress_rules" {
  type    = list(number)
  default = [80, 22, 8080]
}

variable "ami_image_owner" {
  type    = list(string)
  default = ["099720109477"]
}

variable "instance_count" {
  default = 3
}

variable "instance_name" {
  default = ""
}

variable "master" {
  default = "capstone-master"
}

variable "worker" {
  default = "capstone-worker"
}
