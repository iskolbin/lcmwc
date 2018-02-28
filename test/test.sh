#!/bin/bash

SEED=$1
N=$2

if [ -z $SEED ]; then
	echo "Seed is not specified"
	exit 1
fi

if [ -z $N ]; then
	echo "Count of items to generate is not specified"
	exit 1
fi

gcc -std=c99 -o test/ctest test/test.c
./test/ctest $SEED $N > test/c_result.txt
lua test/test.lua $SEED $N > test/lua_result.txt
diff test/c_result.txt test/lua_result.txt
