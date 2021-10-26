#!/bin/bash

DOCKER_FILE="Dockerfile"

# get the list of changed files in last commit
FILE_DIFF=$(git diff-tree --no-commit-id --name-status -r HEAD~1..HEAD | grep ^[ACMR])

# for each folder that contains a Dockerfile
# folder name cannot contain space
for F in $FILE_DIFF
do
  echo "Checking ${F}..."
  if [[ $F = *$DOCKER_FILE ]]; then
    DIR=${F%/$DOCKER_FILE}
    NAME=${DIR#*/}
    TAG="${DOCKER_ORG}/${NAME}"
    echo "Building ${TAG} from ${DIR}"
    docker build -t $TAG --build-arg NRP77_NLP_ANALYSIS_REPO_TOKEN=${NRP77_NLP_ANALYSIS_REPO_TOKEN} $DIR
    # if we could not build then exit with error
    if [ $? -ne 0 ]; then
      exit 1
    fi

  fi
done
