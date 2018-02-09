#!/bin/bash

DOCKER_FILE="Dockerfile"

# get the list of changed files in last commit
FILE_DIFF=$(git diff-tree --no-commit-id --name-only -r HEAD~1..HEAD)

# for each folder that contains a Dockerfile
for F in $FILE_DIFF
do
  if [[ $F = *$DOCKER_FILE ]]; then
    DIR=${F%/$DOCKER_FILE}
    NAME=${DIR#*/}
    TAG="${DOCKER_ORG}/${NAME}"
    docker build -t $TAG $DIR

    # if we could not build then exit with error
    if [ $? -ne 0 ]; then
      exit 1
    fi

  fi
done
