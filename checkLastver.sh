#!/bin/bash

images=$(docker images --format "{{.Tag}}:")

for tag in $images; do
  if [[ $tag == *"$1"* ]]; then
    echo "its there. deleting version $1..."
    docker rmi $2
  fi
done

