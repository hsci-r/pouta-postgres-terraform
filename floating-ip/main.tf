resource "openstack_networking_floatingip_v2" "floatip" {
  pool = "public"
}