resource "random_password" "postgres_root_password" {
  length           = 16
  min_lower        = 1
  min_upper        = 1
  min_special      = 1
  min_numeric      = 1
  override_special = "!#%&*()-_=+[]{}<>:?"
  count = var.postgres_root_password == "" ? 1 : 0
}

locals {
  postgres_root_password = var.postgres_root_password != "" ? var.postgres_root_password : one(random_password.postgres_root_password[*].result)
}

resource "openstack_compute_volume_attach_v2" "va" {
  instance_id = openstack_compute_instance_v2.server.id
  volume_id   = var.volume_id
  device = "/dev/vdc"
}

resource "openstack_compute_instance_v2" "server" {
  name            = "${var.project_name}-postgres"
  image_name      = "Ubuntu-22.04"
  flavor_name     = var.vm_flavour
  key_pair        = var.project_name
  security_groups = ["default",var.ssh_mosh_secgroup_id,var.postgres_secgroup_id]
  network {
    name = var.project_id
  }
  user_data = templatefile("cloud-config.yaml", { 
    project_name=var.project_name, 
    postgres_root_user=var.postgres_root_user, 
    postgres_root_password=local.postgres_root_password, 
    postgres_database=var.postgres_database
  })
}

resource "openstack_compute_floatingip_associate_v2" "associate_ip" {
  floating_ip = var.floating_ip
  instance_id = openstack_compute_instance_v2.server.id
}

