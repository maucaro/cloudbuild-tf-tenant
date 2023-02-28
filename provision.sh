# expects a tenant (short name) as the first parameter ($1)
if [ -z "$1" ]; then 
  echo "Tenant short name must be provided"
  exit
fi
PROJECT=$(gcloud config get project)
REGION=us-central1
TRIGGER=ea7141d5-24cd-4771-ba0b-9a755f2d7162
ACCESS_TOKEN=$(gcloud auth print-access-token)
DATA="{\"projectId\":\"${PROJECT}\",\"triggerId\":\"${TRIGGER}\",\"source\":{\"substitutions\":{\"_TENANT\":\"$1\"}}}"
echo $DATA
curl --request POST \
  "https://cloudbuild.googleapis.com/v1/projects/${PROJECT}/locations/us-central1/triggers/${TRIGGER}:run" \
  --header "Authorization: Bearer ${ACCESS_TOKEN}" \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data $DATA \
  --compressed
