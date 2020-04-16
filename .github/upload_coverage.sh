#!/bin/bash

DECIDIM_MODULE=$1
EVENT_PAYLOAD_FILE=$2

PRID=`jq ".number // .check_run.pull_requests[0].number" $EVENT_PAYLOAD_FILE`
SHA=`jq -r ".pull_request.head.sha // .check_run.head_sha // .after" $EVENT_PAYLOAD_FILE`

if [ $PRID = "null" ]
then
  echo "bash <(curl -s https://codecov.io/bash) -s coverage -n $DECIDIM_MODULE -C $SHA"
else
  echo "bash <(curl -s https://codecov.io/bash) -s coverage -n $DECIDIM_MODULE -C $SHA -P $PRID"
fi
