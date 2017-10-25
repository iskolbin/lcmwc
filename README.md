Lua Persistent CMWC-4096 PRNG
=============================

Lua persistent [CMWC4096 algorithm by George Marsaglia](https://en.wikipedia.org/wiki/Multiply-with-carry).
This algorithm gives good statistical results, huge period and also quite
performant (original algorithm of course). Note that random function has
only 32-bit precision.

Cmwc.make( seed: number )
-------------------------

Create new CMWC-4096 PRNG state. Initialization procedure is based on [LCG](
https://en.wikipedia.org/wiki/Linear_congruential_generator) and is borrowed
from [libtcod](http://roguecentral.org/doryen/libtcod/) sources.

Cmwc.random( cmwc: Cmwc, min: number, max: number )
---------------------------------------------------

Generate new pseudorandom number and update state. Returns 2 values: updated
state and generated number. This function API tries to mimic one from original
Lua.

Performance
===========

Simple benchmark included. For LuaJIT on my notebook it's x2 performance drop,
for vanilla Lua...x14. Well, it's slow. The problem is huge amount of generated
garbage.
