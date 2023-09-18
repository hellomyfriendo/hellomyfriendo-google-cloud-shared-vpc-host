locals {
  cloudbuild_apps_sa_org_roles = [
    "roles/orgpolicy.policyAdmin",
    "roles/compute.xpnAdmin",
  ]

  cloudbuild_apps_sa_project_roles = [
    "roles/compute.networkAdmin",
    "roles/compute.securityAdmin",
    "roles/logging.admin",
    "roles/storage.admin",
    "roles/vpcaccess.admin"
  ]
}

resource "google_service_account" "cloudbuild_apps" {
  account_id   = "cloudbuild-apps"
  display_name = "CloudBuild Apps Service Account"
}

resource "google_organization_iam_member" "cloudbuild_apps_sa" {
  for_each = toset(local.cloudbuild_apps_sa_org_roles)
  org_id   = var.org_id
  role     = each.value
  member   = "serviceAccount:${google_service_account.cloudbuild_apps.email}"
}

resource "google_project_iam_member" "cloudbuild_apps_sa" {
  for_each = toset(local.cloudbuild_apps_sa_project_roles)
  project  = data.google_project.project.id
  role     = each.value
  member   = "serviceAccount:${google_service_account.cloudbuild_apps.email}"
}

resource "google_sourcerepo_repository_iam_member" "cloudbuild_apps_sa" {
  repository = var.sourcerepo_name
  role       = "roles/viewer"
  member     = "serviceAccount:${google_service_account.cloudbuild_apps.email}"
}
