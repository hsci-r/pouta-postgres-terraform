output "postgres_root_password" {
  sensitive = true
  value = local.postgres_root_password
}

