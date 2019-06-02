variable "auth_url" {
    type = "string"
    description = "this is the url to the openstack api endpoint"
}

variable "env_name" {
    description = "this is the name of the test environment"
    default = "nextcloud" 
}

variable "allow_ssh_from_v4" {
    type = "list"
    default = []
}

variable "region" {
    type = "string"
    default = "no-south-1"
}

variable "nextcloud_ip" {}
variable "collabora_ip" {}
