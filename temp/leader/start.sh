#!/usr/bin/env bash
set -e

JUSER="jenkins"
DOCKER_GROUP="hostdocker"

FILE=/var/run/docker.sock

if [ -e ${FILE} ]; then
    DOCKER_GID=$(ls -aln ${FILE}  | awk '{print $4}')

    if ! getent group ${DOCKER_GID}; then
        echo creating ${DOCKER_GROUP} group ${DOCKER_GID}
        addgroup --gid ${DOCKER_GID} ${DOCKER_GROUP}
    fi

    FINAL_GROUP=$(getent group ${DOCKER_GID} | awk -F: '{print $1}')

    if ! id -nG "$JUSER" | grep -qw "$FINAL_GROUP"; then
       echo Adding ${FINAL_GROUP} to ${JUSER}
       usermod -a -G ${FINAL_GROUP} ${JUSER}
    fi
fi
# TODO: work out why this happens intermittently
chown -R ${JUSER}:${JUSER} /var/jenkins_home/

# When you update plugins in container and then mount existing data
# updated plugins are not recognised as stale data is still kept. Hence:
if [ -d /var/jenkins_home/plugins ]; then
    rm -rf /var/jenkins_home/plugins/*
fi

exec su ${JUSER} -c "/bin/tini -- /usr/local/bin/jenkins.sh"
