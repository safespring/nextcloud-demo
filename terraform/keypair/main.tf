# create a keypair for later use and output the private key
variable prefix {
  type = "string"
  description = "a unique prefix that describes the keypair"
}

resource "random_id" "rid" {
  byte_length = 12
}

resource "openstack_compute_keypair_v2" "keypair" {
  name       = "${var.prefix}-keypair-${random_id.rid.hex}"
}

output "name" {
  value = "${openstack_compute_keypair_v2.keypair.name}"
}

output "ssh_public_key" {
  value = "${openstack_compute_keypair_v2.keypair.public_key}"
}

output "ssh_private_key" {
  value = "${openstack_compute_keypair_v2.keypair.private_key}"
  sensitive = true
}
