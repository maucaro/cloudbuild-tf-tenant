code=$(curl -o /dev/null -s -w "%{http_code}\n" "https://checkpoint-api.hashicorp.com/v1/check/terraform?operation=create&tenant=${1}")
if [ $code != $2 ] ; then
  exit 1
fi