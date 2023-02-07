#!/bin/bash
set -e

echo ${INPUT_TITLE}

header='{
          "type": "header",
          "text": {
          "type": "plain_text",
          "text": ${INPUT_TITLE}
          }
        },'
        
divider='{
  "type": "divider"
},'

# Slack markdown doesn't accept empty `text`
if [ ! -z '${INPUT_BODY}' ]
then
  body='{
    "type": "section",
    "text": {
    "type": "mrkdwn",
    "text": ${INPUT_BODY}
    }
  },'
fi

context='{
  "type": "context",
  "elements": [
  {
    "type": "plain_text",
    "text": ${INPUT_CONTEXT}
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

curl ${INPUT_WEBHOOK_URL} \
  --request POST \
  --header 'Content-type: application/json' \
  --data "$data"
