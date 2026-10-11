variable "opensearch_domain_policies" {
  description = <<EOT
Map of opensearch_domain_policies, attributes below
Required:
    - access_policies
    - domain_name
Optional:
    - region
EOT

  type = map(object({
    access_policies = string
    domain_name     = string
    region          = optional(string)
  }))
  validation {
    condition = alltrue([
      for k, v in var.opensearch_domain_policies : (
        can(jsondecode(v.access_policies))
      )
    ])
    error_message = "must be valid JSON"
  }
}

