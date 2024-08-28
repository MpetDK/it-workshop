variable "vm_count" {
  description = "Antal VM'er til deltagere"
  default     = 1
}

variable "zone" {
  description = "GCP zone for VM'er"
  default     = "europe-west4-a"  # Ændr dette til din ønskede zone
}

resource "google_compute_instance" "workshop_vm" {
  count        = var.vm_count
  name         = "workshop-vm-${count.index + 1}"
  machine_type = "n1-standard-4"
  zone = var.zone

allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 50
      type  = "pd-balanced"
    }
  }

/*
guest_accelerator {
    type  = "nvidia-tesla-p4"  
    count = 1
  }
*/
  network_interface {
    network    = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.subnet.self_link
    access_config {nat_ip = google_compute_address.static_ip.address}  # Tildel en ekstern IP-adresse
  }

  service_account {
    email  = "default"
    scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  metadata_startup_script = file("${path.module}/startup_script.sh")

  tags = ["allow-ssh-ws", "allow-rdp-ws", "allow-http-ws"]
}

output "external_ips" {
  value = [for inst in google_compute_instance.workshop_vm : inst.network_interface[0].access_config[0].nat_ip]
}