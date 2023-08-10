resource "openstack_compute_keypair_v2" "keypair" {
  name       = var.project_name
  public_key = var.keypair
}
