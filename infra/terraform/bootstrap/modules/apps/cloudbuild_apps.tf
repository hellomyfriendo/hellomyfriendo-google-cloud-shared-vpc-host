data "google_service_account" "cloudbuild_apps" {
  account_id = var.cloudbuild_apps_sa_email
}

resource "google_cloudbuild_trigger" "apps" {
  name            = "apps"
  description     = "Build and deploy the apps"
  service_account = data.google_service_account.cloudbuild_apps.id

  trigger_template {
    repo_name   = var.sourcerepo_name
    branch_name = var.branch_name
  }

  filename = "infra/cloudbuild/apps/cloudbuild.yaml"

  substitutions = {
    _TFSTATE_BUCKET = var.tfstate_bucket
    _ORG_ID         = var.org_id
    _REGION         = var.region
    _ENVIRONMENT    = var.environment
  }
}
