terraform {
  required_version = ">=1.1.0"
  required_providers {
    google = {
      source = "hashicorp/google"
    }
  }
}

provider "google" {
  project = "my-project"
  region  = "us-west2"
  zone    = "us-west2-a"
}

resource "google_compute_disk" "disk_to_backup" {
  name = "disk-to-backup"
  type = "pd-balanced"
}

resource "google_compute_disk" "disk_to_backup_2" {
  name = "disk-to-backup-2"
  type = "pd-balanced"
}

module "snapshot-policy" {
  source      = "kasna-cloud/snapshot-policy/google"
  disks       = [google_compute_disk.disk_to_backup.name, google_compute_disk.disk_to_backup_2.name]
  policy_name = "snapshot-policy"

  schedule = {
    weekly_schedule = {
      day        = "MONDAY"
      start_time = "04:00"
    }
    # daily_schedule = {
    #   start_time = "04:00"
    # }
    # hourly_schedule = {
    #   hours_in_cycle = 14
    #   start_time     = "04:00"
    # }
  }
}
