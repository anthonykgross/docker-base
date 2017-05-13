#!/bin/bash

if [ $USER_UID -eq 0 ]; then
    echo "You're root ! Use 'gosu' to change"
fi