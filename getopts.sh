#!/bin/bash

while getopts b:n: OPT
do
  case $OPT in
    b) base="$OPTARG" ;;
    n) next="$OPTARG" ;;
    *) :
  esac
done

echo "test"
echo ${base}
echo ${next}