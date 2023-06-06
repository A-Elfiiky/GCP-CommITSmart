# main.tf

# Google Cloud provider configuration
provider "google" {
  credentials = file("path/to/service-account-key.json")
  project     = "your-project-id"
  region      = "us-central1"
}

# GKE Cluster
resource "google_container_cluster" "my_cluster" {
  name               = "my-cluster"
  location           = "us-central1"
  initial_node_count = 3
}

# GKE Node Pool
resource "google_container_node_pool" "my_node_pool" {
  name       = "my-node-pool"
  cluster    = google_container_cluster.my_cluster.name
  node_count = 3

  node_config {
    machine_type = "n1-standard-2"
    disk_size_gb = 100
  }
}

# GKE Cluster Firewall Rule
resource "google_compute_firewall" "my_firewall" {
  name    = "my-firewall"
  network = "default"
  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }
  source_ranges = ["0.0.0.0/0"]
}

# GCP Persistent Disk
resource "google_compute_disk" "my_disk" {
  name  = "my-disk"
  type  = "pd-ssd"
  size  = 100
  zone  = "us-central1-a"
}

# GCP Cloud SQL Instance
resource "google_sql_database_instance" "my_instance" {
  name             = "my-instance"
  database_version = "MYSQL_8_0"
  region           = "us-central1"
  settings {
    tier = "db-n1-standard-1"
    backup_start_time = "05:00"
  }
}

# GCP Cloud SQL Database
resource "google_sql_database" "my_database" {
  name     = "my-database"
  instance = google_sql_database_instance.my_instance.name
}

# GCP Cloud Storage Bucket
resource "google_storage_bucket" "my_bucket" {
  name          = "my-storage-bucket"
  location      = "us-central1"
  force_destroy = true
}

# GCP Cloud Storage Object
resource "google_storage_bucket_object" "my_object" {
  name   = "my-file.txt"
  bucket = google_storage_bucket.my_bucket.name
  source = "path/to/local/file.txt"
}
