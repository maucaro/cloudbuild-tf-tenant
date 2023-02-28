# expects a tenant (short name) as the first parameter ($1)
if [ -z "$1" ]; then 
  echo "Tenant short name must be provided"
  exit
fi
# Modify environment variables as needed
PROJECT=$(gcloud config get project)
REGION=us-central1
TRIGGER=3171e633-43cc-478c-96a4-e669052c0ea8
ACCESS_TOKEN=$(gcloud auth print-access-token)
DATA="{\"projectId\":\"${PROJECT}\",\"triggerId\":\"${TRIGGER}\",\"source\":{\"tagName\":\"$1\",\"substitutions\":{\"_TENANT\":\"$1\"}}}"
echo $DATA
curl --request POST \
  "https://cloudbuild.googleapis.com/v1/projects/${PROJECT}/locations/us-central1/triggers/${TRIGGER}:run" \
  --header "Authorization: Bearer ${ACCESS_TOKEN}" \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data $DATA \
  --compressed
