#!/bin/bash

images=$(docker images --format "{{.Tag}}:")

for tag in $images; do
  if [[ $tag == *"${lastversion}"* ]]; then
    echo "its there"
  fi
done

