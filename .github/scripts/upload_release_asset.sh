#!/bin/bash
set -e

if [[ $# -ne 1 ]] || [[ ! -f "$1" ]]; then
    echo "The full path of the file to upload must be passed as an argument"
    exit 22
fi

UPLOAD_URL=$(jq -r .release.upload_url "${GITHUB_EVENT_PATH}" | sed "s/{?name,label}//g")
UPLOAD_URL="${UPLOAD_URL}?name=$(basename $1)"

status_code=$(curl -L -s -o /dev/null -w "%{http_code}" \
    -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer ${SECRETS_GITHUB_TOKEN}" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    -H "Content-Type: application/octet-stream" \
    ${UPLOAD_URL} \
    --data-binary @$1)

if [[ "${status_code}" = "422" ]]; then
    echo "File already exists"
elif [[ ! "${status_code}" = "201" ]]; then
    echo "${status_code}"
    exit 22
fi
