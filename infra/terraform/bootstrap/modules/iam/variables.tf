variable "org_id" {
  type        = string
  description = " The numeric ID of the organization."
}

variable "confidential_kms_crypto_key" {
  type        = string
  description = "The Confidential KMS crypto key."
}

variable "sourcerepo_name" {
  type        = string
  description = "The Cloud Source Repository name."
}