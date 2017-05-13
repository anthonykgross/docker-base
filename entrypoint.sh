#!/bin/bash
set -e

export USER_UID=$(stat -c "%u" .)
export USER_GID=$(stat -c "%g" .)

echo "Starting with : $(id)"

if [ `grep -c '^docker:' /etc/passwd` -eq 0 ]; then
    if [ $USER_UID -ne 0 ]; then
        useradd -u $USER_UID -g $USER_GID docker
    fi
fi

exec "$@"