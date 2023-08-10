output "postgres_secgroup_id" {
  description = "The ID of the security group exposing postgres ports"
  value = openstack_networking_secgroup_v2.postgres.id
}
