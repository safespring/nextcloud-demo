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

data "openstack_networking_floatingip_v2" "nextcloud_ip" {
  address = "${var.nextcloud_ip}"
}

data "openstack_networking_floatingip_v2" "collabora_ip" {
  address = "${var.collabora_ip}"
}

module "nextcloud-instance" {
    source = "./openstack-instance"
    keypair = "${module.ssh_keypair.name}"
    names = ["nextcloud"]
    user_data = "${file("nextcloud.conf")}"    
    ssh_security_group = "${module.nextcloud-network.ssh_security_group}"
    http_security_group = "${module.nextcloud-network.http_security_group}"
    https_security_group = "${module.nextcloud-network.https_security_group}"
    network_id = "${module.nextcloud-network.network_id}"
    env_name = "${var.env_name}"
    floating_ip_address = "${data.openstack_networking_floatingip_v2.nextcloud_ip.address}"
}

module "collabora-instance" {
    source = "./openstack-instance"
    keypair = "${module.ssh_keypair.name}"
    names = ["collabora"]
    user_data = "${file("collabora.conf")}"
    ssh_security_group = "${module.nextcloud-network.ssh_security_group}"
    http_security_group = "${module.nextcloud-network.http_security_group}"
    https_security_group = "${module.nextcloud-network.https_security_group}"
    network_id = "${module.nextcloud-network.network_id}"
    env_name = "${var.env_name}"
    floating_ip_address = "${data.openstack_networking_floatingip_v2.collabora_ip.address}"
}

output "ssh_private_key" {
    value = "${module.ssh_keypair.ssh_private_key}"
    sensitive = true
}

output "nextcloud_address" {
    value = "${module.nextcloud-instance.address}"
}

output "collabora_address" {
    value = "${module.collabora-instance.address}"
}
