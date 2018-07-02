[![Build Status](https://travis-ci.org/iskolbin/lcmwc.svg?branch=master)](https://travis-ci.org/iskolbin/lcmwc)
[![license](https://img.shields.io/badge/license-public%20domain-blue.svg)](http://unlicense.org/)
[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php)

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

Cmwc.rand( state: number[4097] )
--------------------------------

Generates unsigned 32-bits integer, returns number, updated state, new index

Cmwc.random32( state: number[4097], index: number, min: number, max: number )
-----------------------------------------------------------------------------

Generates new pseudorandom number and update state. Returns 3 values: number,
updated state, next index. This function API tries to somehow mimic one from
the original Lua

Cmwc.random64( state: number[4097], index: number, min: number, max: number )
-----------------------------------------------------------------------------

Takes 2 numbers from the state to create double float. This is much more precise
than `Cmwc.random32` but 2 times slower

Performance
===========

Simple benchmark included with comparsion with builtin randoms is provided.
For LuaJIT on my notebook it's x2 performance drop, for vanilla Lua x7. For
doubles its x4 and x14.
