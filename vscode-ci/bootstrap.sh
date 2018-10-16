#!/bin/bash

echo "[INFO] Starting Xvfb"
export DISPLAY=:1

# Temporary fix to avoid GitLab CI calling the entrypoint twice 
# as described in https://gitlab.com/gitlab-org/gitlab-runner/issues/1380
if [[ ! -f /ci_runned ]] ; then
    Xvfb ${DISPLAY} -screen 0 1024x768x16 &

    timeout=5
    loopCount=0
    until xdpyinfo -display ${DISPLAY} > /dev/null 2>&1
    do
        loopCount=$((loopCount+1))
        sleep 1
        if [ ${loopCount} -gt ${timeout} ]
        then
            echo "[ERROR] Xvfb failed to start."
            exit 1
        fi
    done

fi

[[ $CI ]] && touch /ci_runned

exec "$@"
