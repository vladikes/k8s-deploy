variable "AWS_REGION" {
  type = string
}

variable "AWS_KEY_PAIR" {
  type = string
}

resource "aws_key_pair" "k8s-demo" {
  key_name   = var.AWS_KEY_PAIR
  public_key = file("k8s-demo.pub")
}

resource "aws_instance" "k8s-instance" {
key_name        = aws_key_pair.k8s-demo.key_name
ami             = lookup(var.ami, var.AWS_REGION)
subnet_id = var.AWS_SUBNET_ID
security_groups = var.AWS_SECURITY_GROUPS
tags = {
    Name = element(var.instance_tags, count.index)
  }
}

resource "time_sleep" "wait_for_k8s_environments" {
create_duration = "110s"
depends_on      = [aws_instance.k8s-instance]
}

variable "ami" {
  type = "map"

  default = {
    var.AWS_REGION = "ami-xxxx"
    var.AWS_REGION = "ami-xxxx"
  }
}

variable "instance_count" {
  default = "2"
}

variable "instance_tags" {
  type = list
  default = ["k8s-1", "k8s-2"]
}

variable "instance_type" {
  default = "t3.medium"
}
