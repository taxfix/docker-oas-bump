#!/bin/sh
if [ ! -f "/opt/app/swagger.json" ]; then
    echo "specs not found"
    exit 0
fi
swagger-inline "/opt/app/src/**/*.(ts|js)" -b swagger.json -f ".json" > /tmp/out.json
swagger-cli validate /tmp/out.json
