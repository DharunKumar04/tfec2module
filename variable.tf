variable "key_name" {
  type    = string
}

variable "subnet_id" {
  type    = string
}

variable "windows_tags" {
  type = map(string)
  default = {
    Name = "Windows EC2 Instance"
  }
}

variable "ubuntu_tags" {
  type = map(string)
  default = {
    Name = "Ubuntu EC2 Instance"
  }
}

variable "windows_instance_count" {
  type = number
}

variable "ubuntu_instance_count" {
  type = number
}

variable "instance_type" {
  type    = string
}
