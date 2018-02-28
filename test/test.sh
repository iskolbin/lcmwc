#!/bin/bash

SEED=433494437 
N=10

gcc test/test.c
./a.out $SEED $N > test/c_result.txt
lua test/test.lua $SEED $N > test/lua_result.txt
diff test/c_result.txt test/lua_result.txt
