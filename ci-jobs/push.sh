#!/bin/bash

DOCKER_FILE="Dockerfile"

# get the list of changed files in last commit
FILE_DIFF=$(git diff-tree --no-commit-id --name-status -r HEAD~1..HEAD | grep ^[ACMR])

# login to dockerhub
echo "$DOCKER_ID_PASSWORD" | docker login -u="$DOCKER_ID_USER" --password-stdin

# if we could not login then exit with error
if [ $? -ne 0 ]; then
  exit 1
fi

# for each folder that contains a Dockerfile
# folder name cannot contain space
for F in $FILE_DIFF
do
  echo "Checking ${F}..."
  if [[ $F =~ *$DOCKER_FILE ]]; then
    DIR=${F%/$DOCKER_FILE}
    NAME=${DIR#*/}
    TAG="${DOCKER_ORG}/${NAME}"
    echo "Pushing ${TAG} from ${DIR}"
    docker push $TAG

    # if we could not push then exit with error
    if [ $? -ne 0 ]; then
      exit 1
    fi

  fi
done

# logout from dockerhub
docker logout
