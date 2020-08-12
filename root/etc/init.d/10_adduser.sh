#!/bin/bash

GROUPID=${GROUPID:-65537}

echo "docker:x:$GROUPID:jenkins" >> /etc/group