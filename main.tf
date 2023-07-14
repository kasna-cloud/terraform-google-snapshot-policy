locals {
  # Checks if the value exists, otherwise sets to a blank list. Otherwise nest the object into a list
  # weekly_schedule = [] OR [{ObjectData}]
  weekly_schedule = try(var.schedule.weekly_schedule.start_time, null) == null ? [] : [var.schedule.weekly_schedule]
  hourly_schedule = try(var.schedule.hourly_schedule.start_time, null) == null ? [] : [var.schedule.hourly_schedule]
  daily_schedule  = try(var.schedule.daily_schedule.start_time, null) == null ? [] : [var.schedule.daily_schedule]
}

# Snapshot schedule
resource "google_compute_disk_resource_policy_attachment" "attachment" {
  for_each = var.disks

  name    = google_compute_resource_policy.main.name
  disk    = each.key
  project = var.project_id
  zone    = var.zone

  lifecycle {
    # We need to remove the attachment when any changes to the schedule are made
    replace_triggered_by = [google_compute_resource_policy.main]
  }
}

# A policy that can be attached to a resource to specify or schedule actions on that resource.
resource "google_compute_resource_policy" "main" {
  name    = var.policy_name
  project = var.project_id
  region  = var.region

  snapshot_schedule_policy {
    schedule {
      # In the locals we nest the object into a list. We can dynamically create 0 or 1 schedule based on that.
      dynamic "weekly_schedule" {
        for_each = local.weekly_schedule
        content {
          day_of_weeks {
            day        = weekly_schedule.value["day"]
            start_time = weekly_schedule.value["start_time"]
          }
        }
      }
      dynamic "hourly_schedule" {
        for_each = local.hourly_schedule
        content {
          hours_in_cycle = hourly_schedule.value["hours_in_cycle"]
          start_time     = hourly_schedule.value["start_time"]
        }
      }
      dynamic "daily_schedule" {
        for_each = local.daily_schedule
        content {
          # A daily schedule must have a days_in_cycle value of 1 (must happen every day. Use a weekly schedule for more options)
          days_in_cycle = 1
          start_time    = daily_schedule.value["start_time"]
        }
      }
    }
    retention_policy {
      max_retention_days    = var.max_retention_days
      on_source_disk_delete = var.on_source_disk_delete
    }
    snapshot_properties {
      labels            = var.labels
      storage_locations = var.storage_locations
      guest_flush       = var.guest_flush
    }
  }
}
