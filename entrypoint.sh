#!/bin/bash
set -e

API_URL="${INPUT_WEBHOOK}"

echo ${API_URL}

DEPLOYMENT_MESSAGE="${INPUT_SERVICE_NAME} Deployment ${INPUT_ACTION} - ${INPUT_REGION}"
AUTHOR_MSG="Deployment started by ${INPUT_AUTHOR}"

JSON_STRING=$( jq -n \
                  --arg dep_msg "$DEPLOYMENT_MESSAGE" \
                  --arg link "$INPUT_RUN_URL" \
                  --arg author_msg "$AUTHOR_MSG" \
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
                        }.
                        {
                            "type": "section",
                            "text": {
                                "type": "mrkdwn",
                                "text": $author_msg
                            }
                        }
                    ]
                }'
            )

curl -X POST "${API_URL}" -H "Content-Type: application/json" --data "${JSON_STRING}"