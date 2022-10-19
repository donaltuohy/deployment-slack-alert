#!/bin/bash
set -e

API_URL="${INPUT_WEBHOOK}"

echo ${API_URL}

DEPLOYMENT_MESSAGE="${INPUT_SERVICE_NAME} Deployment ${INPUT_ACTION} - ${INPUT_REGION}"

JSON_STRING=$( jq -n \
                  --arg dep_msg "$DEPLOYMENT_MESSAGE" \
                  --arg link "$INPUT_URL" \
                  '{ 
                    "blocks": [ 
                        { 
                            "type": "header",
                            "text": {
                                "type": "plain_text",
                                "text": $dep_msg,
                                "emoji": true
                            }
                        },
                        {
                            "type": "section",
                            "text": {
                                "type": "mrkdwn",
                                "text": $link
                            }
                        }
                    ]
                }'
            )

curl -X POST "${API_URL}" -H "Content-Type: application/json" --data "${JSON_STRING}"