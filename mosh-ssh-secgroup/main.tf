resource "openstack_networking_secgroup_v2" "ssh_mosh" {
  name = "SSH/MOSH"
  description = "SSH/MOSH"
}

resource "openstack_networking_secgroup_rule_v2" "ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.ssh_mosh.id
}

resource "openstack_networking_secgroup_rule_v2" "mosh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "udp"
  port_range_min    = 60000
  port_range_max    = 61000
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.ssh_mosh.id
}