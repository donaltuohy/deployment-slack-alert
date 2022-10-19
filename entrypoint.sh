#!/bin/bash
set -e

API_URL="${INPUT_WEBHOOK}"

DEPLOYMENT_MESSAGE="${INPUT_SERVICE_NAME} Deployment ${INPUT_ACTION} - ${INPUT_REGION}"

JSON_STRING=$( jq -n \
                  --arg dep_msg "$DEPLOYMENT_MESSAGE" \
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
                                "text": "*Details:* To do: add links here"
                            }
                        }
                    ]
                }'
            )

curl -X POST "${API_URL}" -d ${JSON_STRING} -H "Content-Type: application/json"