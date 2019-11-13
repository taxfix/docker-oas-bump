FROM node:12.13-alpine
LABEL com.circleci.preserve-entrypoint=true

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

RUN apk add --no-cache curl
RUN npm install oas jqf strip-bom-cli -g

COPY ./generate-publish.sh .

ENTRYPOINT ["./generate-publish.sh"]
