data "aws_ami" "windows_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "ubuntu_ami" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

locals {
  windowsinstances = {
    for i in range(var.windows_instance_count) :
    "windows_instance-${i + 1}" => {
      ami           = data.aws_ami.windows_ami.id
      instance_type = var.instance_type
      key_name      = var.key_name
      subnet_id     = var.subnet_id
      tags          = var.windows_tags
    }
  }
  ubuntuinstances = {
    for i in range(var.ubuntu_instance_count) :
    "ubuntu_instance-${i + 1}" => {
      ami           = data.aws_ami.ubuntu_ami.id
      instance_type = var.instance_type
      key_name      = var.key_name
      subnet_id     = var.subnet_id
      tags          = var.ubuntu_tags
    }
  }
}

resource "aws_instance" "windows_instance" {
  for_each = local.windowsinstances

  ami           = each.value.ami
  instance_type = each.value.instance_type
  key_name      = each.value.key_name
  subnet_id     = each.value.subnet_id
  tags          = each.value.tags
}
resource "aws_instance" "ubuntu_instance" {
  for_each = local.ubuntuinstances

  ami           = each.value.ami
  instance_type = each.value.instance_type
  key_name      = each.value.key_name
  subnet_id     = each.value.subnet_id
  tags          = each.value.tags
}

