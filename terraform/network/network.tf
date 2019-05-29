resource "openstack_networking_network_v2" "network_1" {
    name = "${var.env_name}"
    admin_state_up = true
}

resource "openstack_networking_subnet_v2" "subnet_1" {
    name = "${var.env_name}_subnet"
    network_id = "${openstack_networking_network_v2.network_1.id}"
    cidr = "${var.cidr}"
    ip_version = 4
}

resource "openstack_networking_router_v2" "router_1" {
    name = "${var.env_name}_router"
    external_network_id = "${var.public_v4_network}"
}

resource "openstack_networking_router_interface_v2" "router_interface_1" {
  router_id = "${openstack_networking_router_v2.router_1.id}"
  subnet_id = "${openstack_networking_subnet_v2.subnet_1.id}"
}

resource "openstack_networking_secgroup_v2" "ssh_access" {
    region = "${var.region}"
    name = "${var.env_name}_ssh_access"
    description = "Security group for allowing SSH access"
}


resource "openstack_networking_secgroup_rule_v2" "rule_ssh_access_ipv4" {
#    count = "${length(var.allow_ssh_from_v4)}"
    region = "${var.region}"
    direction = "ingress"
    ethertype = "IPv4"
    protocol = "tcp"
    port_range_min = 22
    port_range_max = 22
#    remote_ip_prefix = "${element(var.allow_ssh_from_v4, count.index)}"
    security_group_id = "${openstack_networking_secgroup_v2.ssh_access.id}"
}


output "id" {
    value = "${openstack_networking_network_v2.network_1.id}"
}

output "ssh_security_group" {
    value = "${openstack_networking_secgroup_v2.ssh_access.id}"
}

output "network_id" {
    value = "${openstack_networking_network_v2.network_1.id}"
}
