#!/bin/bash
VERSION=$( printf "%.1f"'\n' `cat docker/version.txt` )
VERSION=`bc -l <<<"$VERSION+0.1"`
docker build -f docker/Dockerfile . -t kafka --no-cache
docker tag kafka kafka-$VERSION
docker push kafka-$VERSION
docker build -f docker/Dockerfile-utils . -t kafka-utils --no-cache
docker tag kafka-utils kafka-utils-$VERSION
docker push kafka-utils-$VERSION
echo $VERSION > 'docker/version.txt'