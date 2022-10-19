#!/bin/bash
set -e

api_url="${INPUT_WEBHOOK}"

body=$(cat <<EOF
'{"blocks": [{"type": "header","text": {"type": "plain_text","text": "${INPUT_SERVICE_NAME} Deployment ${INPUT_ACTION} - ${INPUT_REGION}","emoji": true}},{"type": "section","text": {"type": "mrkdwn","text": "*REGION:* ${INPUT_REGION}"}}]}'
EOF
)

result=$(curl -X POST "${api_url}" -d ${body}

echo "::set-output name=pokemon_name::$pokemon_name"