output "snapshot_policy_id" {
  description = "ID of the google_compute_resource_policy resource"
  value       = google_compute_resource_policy.main.id
}

output "snapshot_policy_self_link" {
  description = "Self link of the google_compute_resource_policy resource"
  value       = google_compute_resource_policy.main.self_link
}
