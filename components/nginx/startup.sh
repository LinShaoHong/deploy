#!/bin/bash

set -e

export DOCKER_NAME_SERVER=$(awk -F "[ \t]+" '$1=="nameserver" {print $2}' /etc/resolv.conf)
echo "$DOCKER_NAME_SERVER   nameserver">> /etc/hosts

exec nginx