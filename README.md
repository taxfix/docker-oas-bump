Simple docker image to be used, to create and upload openAPI documentation to bump.sh

## How to use

### Used for CI (CircleCI)
Make sure to define `BUMP_DOC_ID` and `BUMP_TOKEN` as env variable in circleCI for that repository.

#### Version 2 - without orbs

1) Add a new job
```yaml
jobs:
  # other steps like build
  publish-api-documentation:
    docker:
      - image: taxfix/oas-bump:latest

    steps:
      - checkout
      - run: cp /generate-publish.sh .
      - run: ./generate-publish.sh
```

2) Add this job to the workflow
```yaml
workflows:
  version: 2
    workflow-name:
      jobs:
        - publish-api-documentation:
          requires:
            - build
          filters:
            branches:
              only:
                - master
```

#### Version 2.1 - with orbs
Coming Soon

### Used as a base image
Just make sure you copy or mount your files with the inline documentation to the image.
Then build and simply run it. The script gets executed as the entrypoint of that image.
Don't forgot to add `BUMP_DOC_ID` and `BUMP_TOKEN` as environment variables to run.

1) Simple Dockerfile
```Dockerfile
FROM taxfix/oas-bump:latest

WORKDIR /

# Make sure you copy all the files with the inline documentation here
COPY ./ .
```

2) Build it
```shell
docker build -t taxfix/oas-bump-app .
```

3) Run it
```shell
docker run -e BUMP_DOC_TOKEN=${BUMP_DOC_TOKEN} -e BUMP_TOKEN=${BUMP_TOKEN} taxfix/oas-bump-app
```
