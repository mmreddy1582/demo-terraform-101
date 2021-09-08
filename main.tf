terraform {
  required_version = ">= 0.12.0"
}

provider "aws" {
}

data "aws_ami" "ubuntu_16_04" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  owners = ["099720109477"]
}

module "server" {
  source = "./server"

  num_webs     = var.num_webs
  identity     = var.identity
  ami          = data.aws_ami.ubuntu_16_04.image_id
  ingress_cidr = var.ingress_cidr
  public_key   = var.public_key
  private_key  = var.private_key
}

### REMOVE
output "pri_var" {
  value = var.private_key
}

output "pri_file" {
  value = file("~/.ssh/id_general")
}

output "pub_var" {
  value = var.public_key
}

output "pub_file" {
  value = file("~/.ssh/id_general.pub")
}