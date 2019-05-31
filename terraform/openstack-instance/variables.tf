# Basebox variable definitions with optional default values
variable "region" {
  type = "string"
  description = "Your region"
  default = "no-south-1"
}

variable "servers" {
  type = "string"
  description = "Number of servers to start"
  default = "0"
}
variable "flavor" {
  type = "map"
  description = "UUID of base (small) flavor"
  default = {
    "no" = "1adf7c0d-eedd-4c5d-a5df-3dd118e5c364"
    "se" = "1493be98-d150-4f69-8154-4d59ea49681c"
  }
}

variable "centos" {
  type = "map"
  description = "UUID of desired Centos image"
  default = {
    "no" = "c6a74f87-259d-4c98-8844-d27a039eba36"
    "se" = "a8ca4409-422b-4554-adc0-bbdb48d552fc"
  }
}

variable "keypair" {
  type = "string"
  description = "your keypair"
}


variable "number_of_instances" {
    description = "this is the number of instances to create"
    default = 1
}

variable "name_prefix" {
    description = "this is the name of the test environment"
    default = "ansible_role_tester" # to be changed later
}

variable "ssh_security_group" {}
variable "network_id" {}
variable "env_name" {}
variable "node_flavor" {
  default = "b.tiny"
}
variable "centos_image" {
  default = "c6a74f87-259d-4c98-8844-d27a039eba36"
}

variable "names" {
  type = "list"
}

variable "user_data" {
  default = "#cloud-config\n"
}
