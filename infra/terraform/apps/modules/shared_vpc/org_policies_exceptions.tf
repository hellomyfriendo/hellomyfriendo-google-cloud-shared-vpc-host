locals {
  org_policy_name_prefix = "projects/${data.google_project.project.project_id}/policies"

  org_policy_parent = "projects/${data.google_project.project.project_id}"
}

resource "google_org_policy_policy" "gcp_restrictNonCmekServices" {
  name   = "${local.org_policy_name_prefix}/gcp.restrictNonCmekServices"
  parent = local.org_policy_parent

  spec {
    rules {
      values {
        denied_values = [
          "aiplatform.googleapis.com",
          "artifactregistry.googleapis.com",
          "bigquery.googleapis.com",
          "bigtable.googleapis.com",
          "cloudfunctions.googleapis.com",
          "composer.googleapis.com",
          "container.googleapis.com",
          "dataflow.googleapis.com",
          "dataproc.googleapis.com",
          "documentai.googleapis.com",
          "logging.googleapis.com",
          "pubsub.googleapis.com",
          "run.googleapis.com",
          "secretmanager.googleapis.com",
          "spanner.googleapis.com",
          "sqladmin.googleapis.com",
          "storage.googleapis.com",
        ]
      }
    }
  }
}