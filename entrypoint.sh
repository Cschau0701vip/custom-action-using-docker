#!/bin/bash
set -e

echo ${INPUT_TITLE}

header='{
          "type": "header",
          "text": {
          "type": "plain_text",
          "text": "${{ inputs.title }}"
          }
        },'
        
divider='{
  "type": "divider"
},'

# Slack markdown doesn't accept empty `text`
if [ ! -z '${{ inputs.body }}' ]
then
  body='{
    "type": "section",
    "text": {
    "type": "mrkdwn",
    "text": "${{ inputs.body }}"
    }
  },'
fi

context='{
  "type": "context",
  "elements": [
  {
    "type": "plain_text",
    "text": "${{ inputs.context }}"
  }
  ]
}'

blocks='"blocks": [
  '$header'
  '$divider'
  '$body'
  '$context'
]'

data='{'$blocks'}'

output=$(curl "${{ inputs.webhook_url }} \
  --request POST \
  --header 'Content-type: application/json' \
  --data '$data'" | jq)
