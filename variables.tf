variable "project_id" {
  description = "The ID of the project in which to provision resources."
  type        = string
  default     = null
}

variable "region" {
  description = "Name of region. Defaults to the Provider region"
  type        = string
  default     = null
}

variable "zone" {
  description = "Name of zone. Defaults to the Provider zone"
  type        = string
  default     = null
}

variable "disks" {
  type        = set(string)
  description = "Disks to attach the policy to"
}

variable "policy_name" {
  type        = string
  description = "Unique name for the backup policy"
}

# Labels and Tags
variable "labels" {
  description = "A set of key/value label pairs to assign to the resources"
  type        = map(string)
  default     = null
}

variable "tags" {
  description = "Tags to attach to the resources"
  type        = list(string)
  default     = null
}

# Backup
variable "max_retention_days" {
  description = "Maximum age of the snapshot that is allowed to be kept in days"
  type        = number
  default     = 10
}

variable "on_source_disk_delete" {
  description = "(Optional) Specifies the behavior to apply to scheduled snapshots when the source disk is deleted. Possible values are: KEEP_AUTO_SNAPSHOTS, APPLY_RETENTION_POLICY"
  type        = string
  default     = "KEEP_AUTO_SNAPSHOTS"
}

variable "storage_locations" {
  description = "Cloud Storage bucket location to store the auto snapshot (regional or multi-regional)"
  type        = list(string)
  default     = ["us"]
}

variable "guest_flush" {
  description = "Whether to perform a 'guest aware' snapshot."
  type        = bool
  default     = true
}

variable "schedule" {
  description = "Available backup options to execute every Nth hour, day or day of week."
  type = object({
    hourly_schedule = optional(object({
      hours_in_cycle = number,
      start_time     = string
    }))
    daily_schedule = optional(object({
      start_time = string
    }))
    weekly_schedule = optional(object({
      day        = string
      start_time = string
    }))
  })
}
