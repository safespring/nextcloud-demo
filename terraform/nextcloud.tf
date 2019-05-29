provider "openstack" {
    user_name = 
    tenant_name =  # OS_PROJECT_NAME
    password = 
    auth_url = 
}

module "ssh_keypair" {
    source = "./keypair"
    prefix = "${var.env_name}"
}

module "network" {
    source = "./network"
    env_name = "${var.env_name}"
}

module "nextcloud-instance" {
    source = "./openstack-instance"
    keypair = "${module.ssh_keypair.name}"
    names = "${var.names}"
    number_of_instances = "${length(var.names)}"
    ssh_security_group = "${module.network.ssh_security_group}"
    network_id = "${module.network.network_id}"
    env_name = "${var.env_name}"
}
