data "google_project" "project" {
}

module "vpc" {
  source  = "terraform-google-modules/network/google"
  version = "~> 7.3"

  project_id      = data.google_project.project.project_id
  network_name    = "${var.environment}-shr-vpc-1"
  description     = "${var.environment} - Shared VPC network - 1. See https://cloud.google.com/architecture/best-practices-vpc-design#multiple-host-project-multiple-service-projects-multiple-shared-vpc."
  routing_mode    = "GLOBAL"
  shared_vpc_host = true

  subnets = [
    {
      subnet_name = "hmf-na-ne-1-${var.environment}-api-subnet-1"
      # TODO(Marcus): Learn how to and plan the IP ranges.
      subnet_ip              = "10.162.0.0/20"
      subnet_region          = "northamerica-northeast1"
      subnets_private_access = true
      # TODO(Marcus): Enable this when I can pay for it.
      # subnet_flow_logs          = true
      # subnet_flow_logs_sampling = "1.0"
    }
  ]
}