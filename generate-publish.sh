#!/bin/sh
# Workaround for CircleCI to get it work
# Somehow its need to be run once, before it actually works,
# otherwise it fails with non parseable json
oas generate > /dev/null 2>&1

oas generate | \
strip-bom | \
jqf 'file => ({ "definition": JSON.stringify(file), "specification": "openapi/v3/json" })' | \
curl \
  -X POST https://bump.sh/api/v1/docs/${BUMP_DOC_ID}/versions \
  -H "Content-Type: application/json" \
  -u "${BUMP_TOKEN}:" \
  -d @-
