variable "project_id" {
  type = string
  description = "Google Cloud Project ID"
}

variable "region" {
  type = string
  description = "Google Cloud Region"
  default = "us-central1"
}

variable "http_status"{
  type = number
  description = "Expected HTTP Staatus. Allows for simulating failure if != 200."
  default = 200
}

variable "tenant" {
  type = string
  description = "Tenant short name. Used in naming of resources."
  validation {
    condition = can(regex("^[a-z][a-z0-9-]{2,8}[a-z0-9]$", var.tenant))
    error_message = "'tenant' must be between 4 and 10 characters, containn only lower case letters, digits and dashes, and start and end with a lower case letter."
  }
}