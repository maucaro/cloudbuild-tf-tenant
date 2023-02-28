provider "google" {
  project = var.project_id
}

module "tenant" {
  source = "./modules/tenant"
  region = var.region
  tenant = var.tenant
  http_status = var.http_status
}