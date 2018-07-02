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

# Compare original C-results with lua-generated
gcc -std=c99 -o test/ctest test/test.c
./test/ctest $SEED $N > test/c_result.txt
for LUA in lua5.1 lua luajit; do
	$LUA test/test.lua $SEED $N > test/lua_result.txt
	diff test/c_result.txt test/lua_result.txt
	# Run simple unit tests
	$LUA test/test2.lua
done
