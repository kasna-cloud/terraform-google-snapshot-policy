# terraform-google-snapshot-policy

This Terraform Module creates and attaches a Snapshot Policy to Zonal Persistent Disks.


This Terraform module will do the following:

* Schedule snapshot
* Attach policy to a resource

After configuration is completed by Terraform, you will be able to configure your server for backups and restores.

## Scheduling Snapshots

A snapshot schedule can be configured to operate daily, weekly, or every Nth hour.
To configure a snapshot schedule, fill in the corresponding `start_time` of the desired schedule type. 
- If you opt for an hourly schedule, you must also provide an `hours_in_cycle` value.
- If you opt for a weekly schedule, you must also provide a `day` value. e.g. `"MONDAY"`


<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Resources

| Name | Type |
|------|------|
| [google_compute_disk_resource_policy_attachment.attachment](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_disk_resource_policy_attachment) | resource |
| [google_compute_resource_policy.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_resource_policy) | resource |
| [google_project_service.compute](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_disks"></a> [disks](#input\_disks) | Disks to attach the policy to | `set(string)` | n/a | yes |
| <a name="input_guest_flush"></a> [guest\_flush](#input\_guest\_flush) | Whether to perform a 'guest aware' snapshot. | `bool` | `true` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of key/value label pairs to assign to the resources | `map(string)` | `null` | no |
| <a name="input_max_retention_days"></a> [max\_retention\_days](#input\_max\_retention\_days) | Maximum age of the snapshot that is allowed to be kept in days | `number` | `10` | no |
| <a name="input_on_source_disk_delete"></a> [on\_source\_disk\_delete](#input\_on\_source\_disk\_delete) | (Optional) Specifies the behavior to apply to scheduled snapshots when the source disk is deleted. Possible values are: KEEP\_AUTO\_SNAPSHOTS, APPLY\_RETENTION\_POLICY | `string` | `"KEEP_AUTO_SNAPSHOTS"` | no |
| <a name="input_policy_name"></a> [policy\_name](#input\_policy\_name) | Unique name for the backup policy | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The ID of the project in which to provision resources. | `string` | `null` | no |
| <a name="input_region"></a> [region](#input\_region) | Name of region. Defaults to the Provider region | `string` | `null` | no |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | Available backup options to execute every Nth hour, day or day of week. | <pre>object({<br>    hourly_schedule = optional(object({<br>      hours_in_cycle = number,<br>      start_time     = string<br>    }))<br>    daily_schedule = optional(object({<br>      start_time = string<br>    }))<br>    weekly_schedule = optional(object({<br>      day        = string<br>      start_time = string<br>    }))<br>  })</pre> | n/a | yes |
| <a name="input_storage_locations"></a> [storage\_locations](#input\_storage\_locations) | Cloud Storage bucket location to store the auto snapshot (regional or multi-regional) | `list(string)` | <pre>[<br>  "us"<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to attach to the resources | `list(string)` | `null` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Name of zone. Defaults to the Provider zone | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_snapshot_policy_id"></a> [snapshot\_policy\_id](#output\_snapshot\_policy\_id) | ID of the google\_compute\_resource\_policy resource |
| <a name="output_snapshot_policy_self_link"></a> [snapshot\_policy\_self\_link](#output\_snapshot\_policy\_self\_link) | Self link of the google\_compute\_resource\_policy resource |
<!-- END_TF_DOCS -->