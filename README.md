Simple docker image to be used, to create and upload openAPI documentation to bump.sh

## How to use

1. Validate

```
docker run -ti --rm -v$(pwd):/opt/app taxfix/oas-bump /validate.sh
```

2. Publish documentation

```
docker run -ti --rm -v$(pwd):/opt/app taxfix/oas-bump /generate-publish.sh
```

### Used for CI
Make sure to define `BUMP_DOC_ID` and `BUMP_TOKEN` as env variables.

#### CircleCI

1) Add a new job
```yaml
jobs:
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

#### GitLab

1. Validate

```
validate-docs:
  stage: build-and-push
  image: taxfix/oas-bump:latest
  before_script:
    - ''
  script:
    - /validate.sh
  environment:
    name: integration
  allow_failure: false
```

2. Publish

```
publish-specs:
  stage: build-and-push
  image: taxfix/oas-bump:latest
  before_script:
    - ''
  script:
    - /generate-publish.sh
  rules:
    - if: $CI_COMMIT_BRANCH == "master"
      when: always
  environment:
    name: integration
  allow_failure: false
```

### Optional features


Generate documentation using swagger-inline (without bump upload)

```
docker run -ti --rm -v$(pwd):/opt/app taxfix/oas-bump /generate.sh
```
