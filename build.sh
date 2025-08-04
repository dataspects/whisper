#!/bin/bash

#######
# Build
#######
export DOCKER_BUILDKIT=1
DOCKERFILE=Dockerfile
IMAGE_TAG=1.0.6
IMAGENAME=dataspects/whisper:$IMAGE_TAG

DO_BUILD=true
DO_EXPORT=false

if [[ "$DO_BUILD" == true ]]; then
echo "Building Docker image $IMAGENAME"
sudo docker buildx create --name multiarch --driver docker-container --use
sudo docker buildx build \
    --file $DOCKERFILE \
    --tag $IMAGENAME \
    --load \
    --no-cache \
    --platform linux/amd64 \
    .
fi

########
# Export
########
FILE_NAME=whisper-$IMAGE_TAG.tar.gz
if [[ "$DO_EXPORT" == true ]]; then
    echo "Exporting Docker image $IMAGENAME to $FILE_NAME"
    sudo docker save $IMAGENAME | gzip > $FILE_NAME
fi