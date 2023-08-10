output "ssh_mosh_secgroup_id" {
  description = "The ID of the security group exposing SSH/MOSH ports"
  value = openstack_networking_secgroup_v2.ssh_mosh.id
}