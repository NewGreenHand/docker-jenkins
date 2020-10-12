#!/bin/bash

# GROUPID=${GROUPID:-65537}

# echo "docker:x:$GROUPID:jenkins" >> /etc/group

PUID=${PUID:-1029}
PGID=${PGID:-65537}

groupmod -o -g "$PGID" jenkins
usermod -o -u "$PUID" jenkins 
