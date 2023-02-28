# Modify environment variables as needed
REGION=us-central1
PROJECT=$(gcloud config get project)
REPO="https://source.developers.google.com/p/${PROJECT}/r/cb"

# Delete Provisioning Cloud Build Trigger - uncomment if required
#gcloud builds triggers delete tenant-provision --region=us-central1

# Create Provisioning Cloud Build Trigger
gcloud beta builds triggers create manual \
  --region=$REGION \
  --name=tenant-provision \
  --repo=$REPO \
  --repo-type=CLOUD_SOURCE_REPOSITORIES \
  --branch=main \
  --build-config=cloudbuild.yaml \
  --substitutions=_EXPECTED_HTTP_STATUS=200,_TENANT=''

# Delete Deprovisioning Cloud Build Trigger - uncomment if required
#gcloud builds triggers delete tenant-deprovision --region=us-central1

# Deprovisioning Cloud Build Trigger
gcloud beta builds triggers create manual \
  --region=$REGION \
  --name=tenant-deprovision \
  --repo=$REPO \
  --repo-type=CLOUD_SOURCE_REPOSITORIES \
  --branch=main \
  --build-config=cloudbuild-deprovision.yaml \
  --substitutions=_EXPECTED_HTTP_STATUS=200,_TENANT=''
