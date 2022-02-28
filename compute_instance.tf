resource "google_compute_address" "internal_with_subnet_and_address" {
  count = var.network_interface.network_ip != null ? 1 : 0

  name         = "${local.vm_name}-ip0"
  subnetwork   = var.network_interface.subnetwork.id
  address_type = "INTERNAL"
  address      = var.network_interface.network_ip
}

resource "google_compute_instance" "default" {
  name                      = local.vm_name
  machine_type              = var.machine_type
  zone                      = var.zone
  tags                      = var.tags
  allow_stopping_for_update = var.allow_stopping_for_update

  boot_disk {
    initialize_params {
      image = var.initialize_params.image
      size  = var.initialize_params.size
      type  = var.initialize_params.type
    }
  }

  network_interface {
    subnetwork = var.network_interface.subnetwork.name
    network_ip = var.network_interface.network_ip != null ? google_compute_address.internal_with_subnet_and_address[0].address : null

    dynamic "access_config" {
      for_each = var.network_interface.access_config != null ? ["1"] : []
      content {
        network_tier = try(var.network_interface.access_config.network_tier, null)
      }
    }

  }

  metadata = var.metadata

  metadata_startup_script = var.metadata_startup_script

  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account.email
    scopes = var.service_account.scopes
  }

  lifecycle {
    ignore_changes = [
      metadata_startup_script,
    ]
  }
}
