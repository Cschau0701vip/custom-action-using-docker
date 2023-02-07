#!/bin/bash
set -e

title=${INPUT_TITLE}
inbody=${INPUT_BODY}
context=${INPUT_CONTEXT}
echo $title
echo $inbody
echo $context

header='{
          "type": "header",
          "text": {
          "type": "plain_text",
          "text": '"$title"'
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
    "text": '"${INPUT_BODY}"'
    }
  },'
fi

context='{
  "type": "context",
  "elements": [
  {
    "type": "plain_text",
    "text": '"$context"'
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
