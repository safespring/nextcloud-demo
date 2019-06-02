# Just use whatever openstack is available
provider "openstack" {
}

# make something
resource "openstack_compute_instance_v2" "os_instance" {
    count = "${var.number_of_instances}"
    name = "${var.names[count.index]}"
    region = "${var.region}"
    image_id = "${var.ubuntu_image}"
    flavor_name = "${var.node_flavor}"
    key_pair = "${var.keypair}"
    security_groups = [
        "${var.ssh_security_group}",
        "${var.http_security_group}",
        "${var.https_security_group}",
        "default"
    ]
    user_data = "${var.user_data}"

    #   Connecting to the set network
    network {
        uuid = "${var.network_id}"
    }

    block_device {
        boot_index = 0
        delete_on_termination = true
        source_type = "image"
        destination_type = "local"
        uuid = "${var.ubuntu_image}"
    }
    lifecycle {
      ignore_changes = ["user_data","id"]
    }
}
resource "openstack_compute_floatingip_v2" "os_instance" {
    count = "${var.number_of_instances}"
    region = "${var.region}"
    pool = "public-v4"
}
resource "openstack_compute_floatingip_associate_v2" "os_instance" {
    count = "${var.number_of_instances}"
    floating_ip = "${var.floating_ip_address}"
    instance_id = "${openstack_compute_instance_v2.os_instance.*.id[count.index]}"
}

output "address" {
  value = ["${openstack_compute_floatingip_v2.os_instance.*.address}"]
}

output "name" {
  value = ["${openstack_compute_instance_v2.os_instance.*.name}"]
}

# output "ipv4" {
#   value = ["${openstack_compute_instance_v2.base.*.access_ip_v4}"]
# }
# 
# output "name" {
#   value = ["${openstack_compute_instance_v2.base.*.name}"]
# }
# 
# output "servers" {
#   value = "${var.servers}"
# }
