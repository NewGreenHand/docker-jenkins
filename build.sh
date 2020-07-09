#!/bin/bash

docker build \
  --tag fillpit/jenkins:latest \
  --force-rm \
    .