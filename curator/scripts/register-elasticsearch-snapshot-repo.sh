#!/bin/bash

# Copyright (c) 2020 Battelle Energy Alliance, LLC.  All rights reserved.

if [ $# -gt 0 ]; then
  ES_URL="$1"
elif [[ -n $ELASTICSEARCH_URL ]]; then
  ES_URL="$ELASTICSEARCH_URL"
elif [[ -n $ES_HOST ]] && [[ -n $ES_PORT ]]; then
  ES_URL="http://$ES_HOST:$ES_PORT"
else
  ES_URL="http://elasticsearch:9200"
fi

[[ -n $CURATOR_SNAPSHOT_REPO ]] && curl -H "Accept: application/json" -H "Content-type: application/json" -XPUT -fsSL "$ES_URL/_snapshot/$CURATOR_SNAPSHOT_REPO" \
  -d "{ \"type\": \"fs\", \"settings\": { \"location\": \"$CURATOR_SNAPSHOT_REPO\", \"compress\": ${CURATOR_SNAPSHOT_COMPRESSED:-false} } }"
