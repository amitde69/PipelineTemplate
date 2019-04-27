#!/bin/bash

test=$(curl 10.0.0.91:2000/amit | grep "success")

if [[ $test == *"Amit de"* ]]; then
  echo "Passed!"
else
  echo "Failed!"
fi
#echo $test
