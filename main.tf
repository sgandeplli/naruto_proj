provider "google" {
  project     = "primal-gear-436812-t0"
  region      = "us-central1"
  zone        = "us-central1-a"
}

resource "google_compute_instance" "default" {
  name         = "web-server"
  machine_type = "e2-medium"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-stream-9"
    }
  }

  network_interface {
    network = "default"
    access_config {
      # Assign a public IP address
    }
  }
  tags = ["http-server"]
  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y git httpd",  # Install Git and Apache
      "sudo git clone https://github.com/sgandeplli/naruto_proj.git /var/www/html",  # Clone your GitHub repo
      "sudo systemctl start httpd",       # Start the Apache server
      "sudo systemctl enable httpd",      # Enable Apache to start on boot
    ]

    connection {
      type        = "ssh"
      user        = "hr376"  # Replace with your SSH username
      private_key = file("/home/hr376/.ssh/id_rsa")  # Local private key path
      host        = self.network_interface[0].access_config[0].nat_ip  # Public IP
    }
  }
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-new"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]  # Allow HTTP traffic from anywhere
}
