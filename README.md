# Using Terraform and Cloud Build in a SaaS environment

This proof-of-concept (POC) demonstrates how to use Terraform and Cloud Build to provision (and deprovision) tenant infrastructure in a SaaS environment. It shows how the following typical challenges can be approached:
- Use Google Cloud Storage (GCS) as a backend for Terraform to store its state, segregating by tenant.
- Rollback (terraform destroy) partially created infrastructure on any error during provisioning (teraform apply) and surfacing the error in Cloud Build.
- Use Terraform's null_resource and the the local-exec provisioner to provision (and deprovision) resources for which no provider exists. Note that this is NOT a best practice and should be used with caution (see [this](https://developer.hashicorp.com/terraform/language/resources/provisioners/null_resource)). Developing a custom provider (see [this](https://www.cloudskillsboost.google/focuses/1204?parent=catalog)) is a more robust approach but it also requires a greater level of effort.
- Use Terraform's null_resource as a way to simulate failure in resource creation in order to test rollback behavior. Setting the variable http_status to a value different than 200 will cause provisioning to fail.

## Usage
- Clone this repo.
- Create a Terraform 1.3.9 image per these [instructions](https://github.com/GoogleCloudPlatform/cloud-builders-community/tree/master/terraform). Use the following as the substitutions parameter:

`--substitutions=_TERRAFORM_VERSION="1.3.9",_TERRAFORM_VERSION_SHA256SUM="53048fa573effdd8f2a59b726234c6f450491fe0ded6931e9f4c6e3df6eece56"`
- Create a GCS bucket with the following name: `gs://${PROJECT_ID}-cloudbuild-logs`
- Create a repo in CSR and push to it.
- Modify deploy.sh with repo name and selected region and execute it to create the triggers.
- Modify provision.sh and deprovision.sh with correct trigger IDs and selected region. Trigger IDs can be obtained with `gcloud beta builds triggers list` 
- Ensure Cloud Build SA has the following roles: 'Source Repository Writer' and 'Storage Object Admin' at the project level or scoped to the previously created GCS bucket and CSR repo (preferred).
- Use provision.sh and deprovision.sh scripts to test each operation.

## Limitations
- The create.sh and delete.sh scripts use the curl command without authentication. This was done for simplicity and would most probably need to be modified in a real use case. 