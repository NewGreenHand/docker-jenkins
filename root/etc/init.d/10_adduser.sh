#!/bin/bash

PUID=${PUID:-1000}
PGID=${PGID:-1000}

groupmod -o -g "$PGID" jenkins
usermod -o -u "$PUID" jenkins