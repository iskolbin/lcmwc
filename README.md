Lua Persistent CMWC-4096 PRNG
=============================

Lua persistent pseudo random number generator. Internally based on
[CMWC4096 algorithm by George Marsaglia](https://en.wikipedia.org/wiki/Multiply-with-carry)
.This algorithm gives good statistical results, it has huge period and it also
very performant (original algorithm of course). Includes versions for 32 and 53
bits precision floats.

Cmwc.make( seed: number )
-------------------------

Create new CMWC-4096 PRNG state. Initialization procedure is based on [LCG](
https://en.wikipedia.org/wiki/Linear_congruential_generator) and is borrowed
from [libtcod](http://roguecentral.org/doryen/libtcod/) sources. Returns state
and initial index (1)

Cmwc.random( state: number[4097], index: nubmer, min: number, max: number )
---------------------------------------------------------------------------

Generate new pseudorandom number and update state. Returns 3 values: updated
state, next index, and generated number. This function API tries to somehow
mimic one from the original Lua

Cmwc.randomdouble( state: number[4097], index: nubmer, min: number, max: number )
---------------------------------------------------------------------------------

Takes 2 numbers from the state to create 53-bit resolution float. This is
much more precise than `Cmwc.random` but 2 times slower

Performance
===========

Simple benchmark included with comparsion with builtin randoms is provided.
For LuaJIT on my notebook it's x2 performance drop, for vanilla Lua x7. For
doubles its x4 and x14.
