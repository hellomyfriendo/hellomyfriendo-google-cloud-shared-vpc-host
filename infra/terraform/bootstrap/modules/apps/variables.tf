variable "org_id" {
  type        = string
  description = " The numeric ID of the organization."
}

variable "region" {
  type        = string
  description = "The default Google Cloud region for the created resources."
}

variable "environment" {
  type        = string
  description = "The project's environment."
}

variable "cloudbuild_apps_sa_email" {
  type        = string
  description = "The email of the Cloud Build apps service account."
}

variable "sourcerepo_name" {
  type        = string
  description = "The Cloud Source Repository name."
}

variable "branch_name" {
  type        = string
  description = "The Cloud Source repository branch name."
}

variable "tfstate_bucket" {
  type        = string
  description = "The GCS bucket to store the project's terraform state."
}