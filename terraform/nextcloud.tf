provider "openstack" {
    auth_url = "${var.auth_url}"
}

module "ssh_keypair" {
    source = "./keypair"
    prefix = "${var.env_name}"
}

module "nextcloud-network" {
    source = "./network"
    cidr = "10.20.0.0/24"
    env_name = "${var.env_name}"
}

module "nextcloud-instance" {
    source = "./openstack-instance"
    keypair = "${module.ssh_keypair.name}"
    names = ["nextcloud"]
    # user_data = "${file("nextcloud.conf")}"    
    ssh_security_group = "${module.nextcloud-network.ssh_security_group}"
    network_id = "${module.nextcloud-network.network_id}"
    env_name = "${var.env_name}"
}

module "collabora-instance" {
    source = "./openstack-instance"
    keypair = "${module.ssh_keypair.name}"
    names = ["collabora"]
    # user_data = "${file("collabora.conf")}"
    ssh_security_group = "${module.nextcloud-network.ssh_security_group}"
    network_id = "${module.nextcloud-network.network_id}"
    env_name = "${var.env_name}"
}
