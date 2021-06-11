#!/bin/sh
if [ ! -f "$PWD/swagger.json" ]; then
    echo "specs not found"
    exit 0
fi
swagger-inline "$PWD/src/**/*.(py|ts|js)" "$PWD/*.(py|ts|js)" -b "$PWD/swagger.json" -f ".json" > api-docs.json

strip-bom api-docs.json \
jqf 'file => ({ "definition": JSON.stringify(file), "specification": "openapi/v3/json" })' | \
curl \
  -X POST https://bump.sh/api/v1/docs/${BUMP_DOC_ID}/versions \
  -H "Content-Type: application/json" \
  -u "${BUMP_TOKEN}:" \
  -d @-
