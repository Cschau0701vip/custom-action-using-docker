#!/bin/bash
set -e

echo ${INPUT_TITLE}
title=${INPUT_TITLE}
echo $title
inbody=${INPUT_BODY}
context=${INPUT_CONTEXT}

header='{
          "type": "header",
          "text": {
          "type": "plain_text",
          "text": '$title'
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
    "text": "$inbody"
    }
  },'
fi

context='{
  "type": "context",
  "elements": [
  {
    "type": "plain_text",
    "text": $context
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

echo $data

curl ${INPUT_WEBHOOK_URL} \
  --request POST \
  --header 'Content-type: application/json' \
  --data "$data"
