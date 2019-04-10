#!/usr/bin/env bash
docker pull jenkinsci/jenkins
docker-compose build --force-rm --pull
docker-compose push
