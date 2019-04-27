#!/bin/bash

text="success"

test=$(curl 10.0.0.91:2000/amit | grep $text)

if [[ $test == *"$text"* ]]; then
  echo "Passed!"
else
  echo "Failed!"
fi
#echo $test
