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
      subnet_name           = "na-ne-1-${var.environment}-vpcaccess-conn-1"
      subnet_ip             = "10.129.0.0/28"
      subnet_region         = "northamerica-northeast1"
      subnet_private_access = "true"
    }
  ]

  depends_on = [
    google_org_policy_policy.gcp_restrictNonCmekServices
  ]
}

module "private_service_access" {
  source      = "GoogleCloudPlatform/sql-db/google//modules/private_service_access"
  version     = "~> 13.0"
  project_id  = data.google_project.project.project_id
  vpc_network = module.vpc.network_name
}

# TODO(Marcus): Raise these values when I can pay for it.
resource "google_vpc_access_connector" "northamerica_northeast1" {
  name          = "na-ne-1-${var.environment}-vpc-con-1"
  machine_type  = "f1-micro"
  min_instances = 2
  max_instances = 3
  subnet {
    name = module.vpc.subnets["northamerica-northeast1/na-ne-1-${var.environment}-vpcaccess-conn-1"].name
  }
}