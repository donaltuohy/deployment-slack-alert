#!/bin/bash
set -e

API_URL="${INPUT_WEBHOOK}"

echo ${API_URL}

DEPLOYMENT_MESSAGE=":white_check_mark: ${INPUT_SERVICE_NAME} Deployment ${INPUT_ACTION} - ${INPUT_REGION}"
AUTHOR_MSG="Deployment initiated by *${INPUT_AUTHOR}*"
LINK_MESSAGE="[Deployment Action URL](${INPUT_RUN_URL})" 

JSON_STRING=$( jq -n \
                  --arg dep_msg "$DEPLOYMENT_MESSAGE" \
                  --arg link "$LINK_MESSAGE" \
                  --arg author_msg "$AUTHOR_MSG" \
                  '{ 
                    "blocks": [ 
                        {
			                "type": "divider"
		                },
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
                        },
                        {
                            "type": "section",
                            "text": {
                                "type": "mrkdwn",
                                "text": $author_msg
                            }
                        },
                        {
			                "type": "divider"
		                }
                    ]
                }'
            )

curl -X POST "${API_URL}" -H "Content-Type: application/json" --data "${JSON_STRING}"