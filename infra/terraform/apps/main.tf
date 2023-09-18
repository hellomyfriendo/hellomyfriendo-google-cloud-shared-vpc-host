provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}

module "shared_vpc" {
  source = "./modules/shared_vpc"

  environment = var.environment
}