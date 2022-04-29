#!/bin/bash

# *********************************************
# Drools Workbench - Docker image build script
# ********************************************

IMAGE_NAME="jboss/drools-workbench-test"
IMAGE_TAG="latest"

## TEST
aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 350801433917.dkr.ecr.eu-west-1.amazonaws.com
docker pull 350801433917.dkr.ecr.eu-west-1.amazonaws.com/enterprise-architect/dedalus-s2i-ubi7-wildfly-openjdk8-jdk:14.0-3

# Build the container image.
echo "Building the Docker container for $IMAGE_NAME:$IMAGE_TAG.."
docker build --rm -t $IMAGE_NAME:$IMAGE_TAG .

echo "Build done"
