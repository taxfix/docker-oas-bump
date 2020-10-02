#!/bin/sh
if [ ! -f swagger.json ]; then
    echo "specs not found"
    exit 0
fi
swagger-inline "src/**/*.(ts|js)" -b swagger.json -f ".json" > /tmp/out.json
swagger-cli validate /tmp/out.json
