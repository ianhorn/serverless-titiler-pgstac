#!/usr/bin/env bash

docker build --platform linux/amd64 -t titiler-pgstac-layer:latest . && \
docker run -it \
    --platform linux/amd64 \
    -v $(pwd):/local \
    titiler-pgstac-layer:latest \
    ./create-lambda-layer.sh