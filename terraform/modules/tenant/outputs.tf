output "network" {
  value = "${google_compute_network.vpc_network}"
}

output "subnet" {
  value = "${google_compute_subnetwork.vpc_subnetwork}"
}