#!/bin/bash

set -e

endpoints="$(docker-compose exec ngrok /bin/bash /ngrok/status)"

for ep in $endpoints; do
  trimmed=$(echo $ep | tr -d '[:space:]' | sed -e 's/tcp:\/\///g' | sed -e 's/:/ /g')

  echo "Verifying endpoint: '$trimmed'"

  $(nc -z ${trimmed})
  if [ $? -eq 1 ]
  then
    exit 1
  fi
done
