#!/bin/sh

if [ ! -f "$PWD/swagger.json" ]; then
    echo "specs not found"
    exit 0
fi

swagger-inline "$PWD/src/**/*.(py|ts|js)" "$PWD/*.(py|ts|js)" -b "$PWD/swagger.json" -f ".json" > /tmp/out.json
swagger-cli validate /tmp/out.json
