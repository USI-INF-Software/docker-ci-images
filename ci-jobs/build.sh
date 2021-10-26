#!/bin/bash

DOCKER_FILE="Dockerfile"

# get the list of changed files in last commit
FILE_DIFF=$(git diff-tree --no-commit-id --name-status -r HEAD~1..HEAD | grep "^[ACMR]")

NRP77_IMAGE_DIR="nrp77-spacy-ci"

# for each folder that contains a Dockerfile
# folder name cannot contain space
for F in $FILE_DIFF
do
  echo "Checking ${F}..."
  if [[ $F = *$DOCKER_FILE ]]; then
    DIR=${F%/"$DOCKER_FILE"}
    NAME=${DIR#*/}
    TAG="${DOCKER_ORG}/${NAME}"

    if [[ "$DIR" = "$NRP77_IMAGE_DIR" ]]; then
      download_nrp77_environment
    fi

    echo "Building ${TAG} from ${DIR}"
    docker build -t "$TAG" "$DIR"
    # if we could not build then exit with error
    if [ $? -ne 0 ]; then
      exit 1
    fi

  fi
done


function download_nrp77_environment {
  wget --header "PRIVATE-TOKEN: ${NRP77_NLP_ANALYSIS_REPO_TOKEN}" \
    https://gitlab.dev.si.usi.ch/api/v4/projects/297/repository/files/environment.yml/raw \
    --output-document="${NRP77_IMAGE_DIR}/environment.yml"
}