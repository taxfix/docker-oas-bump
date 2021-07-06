FROM node:12.13-alpine

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apk add --no-cache curl
RUN npm install swagger-inline@3 jqf strip-bom-cli @apidevtools/swagger-cli -g

COPY ./generate-publish.sh .
COPY ./generate.sh .
COPY ./validate.sh .

RUN chmod +x generate-publish.sh generate.sh validate.sh

WORKDIR /opt/app
