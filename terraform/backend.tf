terraform {
  backend "gcs" {
    bucket = "PROJECT_ID-cloudbuild-logs"
    prefix = "TENANT"
  }
}