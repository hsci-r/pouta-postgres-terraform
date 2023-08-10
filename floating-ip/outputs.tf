output "floating_ip" {
  description = "The floating IP reserved"
  value = openstack_networking_floatingip_v2.floatip.address
}