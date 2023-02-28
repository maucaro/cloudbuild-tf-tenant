terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = ">=4.53.1"
    }
    null = {
      source = "hashicorp/null"
      version = ">=3.2.1"
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "my-custom-mode-network-${var.tenant}"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  name          = "my-custom-subnet-${var.tenant}"
  ip_cidr_range = "10.0.1.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
  depends_on   = [
      null_resource.example
  ] 
}

resource "null_resource" "example" {
  triggers = {
    id = google_compute_network.vpc_network.id
    tenant = var.tenant
    code = var.http_status
  }
  provisioner "local-exec" {
    command = "${path.module}/scripts/create.sh ${self.triggers.tenant} ${self.triggers.code}"
  }
  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/scripts/delete.sh ${self.triggers.tenant} ${self.triggers.code}"
  }
}