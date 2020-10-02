#!/bin/sh
swagger-inline "/opt/app/src/**/*.(ts|js)" -b swagger.json -f ".json" | \
strip-bom | \
jqf 'file => ({ "definition": JSON.stringify(file), "specification": "openapi/v3/json" })' | \
curl \
  -X POST https://bump.sh/api/v1/docs/${BUMP_DOC_ID}/versions \
  -H "Content-Type: application/json" \
  -u "${BUMP_TOKEN}:" \
  -d @-
