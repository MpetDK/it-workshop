variable "region" {
  description = "region"
  default     = "europe-west4"
}

resource "google_compute_network" "vpc_network" {
  name                    = "workshop-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = "workshop-subnet"
  region        = var.region  # Refererer til regionen fra variabler
  network       = google_compute_network.vpc_network.self_link
  ip_cidr_range = "10.0.0.0/16"
}


# statisk IP-adresse
resource "google_compute_address" "static_ip" {
  name   = "workshop-static-ip"
  region = var.region
}


# Allow http
resource "google_compute_firewall" "allow-http" {
  name    = "allow-http-ws"
  network = google_compute_network.vpc_network.self_link  # Korrekt reference
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  
  source_ranges = ["0.0.0.0/0"]
  target_tags    = ["http"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-ws"
  network = google_compute_network.vpc_network.self_link  # Korrekt reference

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]  # Åben adgang til SSH (kan begrænses)
}

resource "google_compute_firewall" "allow_rdp" {
  name    = "allow-rdp-ws"
  network = google_compute_network.vpc_network.self_link  # Korrekt reference

  allow {
    protocol = "tcp"
    ports    = ["3389", "4000"]
  }

  source_ranges = ["0.0.0.0/0"]  # Åben adgang til RDP (kan begrænses)
}