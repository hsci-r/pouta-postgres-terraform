resource "openstack_networking_secgroup_v2" "postgres" {
    name = "postgres"
    description = "postgres"
}

resource "openstack_networking_secgroup_rule_v2" "postgres" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 5432
  port_range_max    = 5432
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.postgres.id
}
