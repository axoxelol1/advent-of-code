#!/bin/bash

if [ "$#" -ne 2 ]; then
  echo "Provide row and col"
  exit 1
fi

r=$1
c=$2

exp=$(((r + c - 2) * (r + c - 1) / 2 + c - 1))

res=1
base=252533
mod=33554393

while [ "$exp" -gt 0 ]; do
  if [ $((exp % 2)) -eq 1 ]; then
    res=$(((res * base) % mod))
  fi
  base=$(((base * base) % mod))
  exp=$((exp / 2))
done

final_code=$(((res * 20151125) % mod))

echo "$final_code"
