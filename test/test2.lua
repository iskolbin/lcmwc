#!/bin/bash

local Cmwc = require('cmwc')
local floor = math.floor

local state, i = Cmwc.make( 1337 )
local v = 0

local function like( a, b )
	return math.abs( a - b ) <= 1e-8
end

v, state, i = Cmwc.random32( state, i )
assert( like( v, state[i-1]/4294967296.0 ))
v, state, i = Cmwc.random32( state, i, 1 )
assert( like( v, 1 ))
assert( not pcall( Cmwc.random32, state, i, 0 ))
v, state, i = Cmwc.random32( state, i, 10, 100 )
assert( like, v, state[i-1] % floor( 100 - 10 ) + 10 )
v, state, i = Cmwc.random32( state, i, -100, -10 )
assert( like, v, state[i-1] % floor( -10 - -100 ) + -100 )
v, state, i = Cmwc.random32( state, i, -100, -100 )
assert( like, v, -100 )
assert( not pcall( Cmwc.random32, state, i, 1, 0 ))

v, state, i = Cmwc.random64( state, i )
assert( like( v, (state[i-2]*67108864.0+state[i-1])*(1.0/9007199254740992.0)))
v, state, i = Cmwc.random64( state, i, 54 )
assert( like( v, 1+((state[i-2]*67108864+state[i-1]) % 54)))
assert( not pcall( Cmwc.random64, state, i, 0 ))
v, state, i = Cmwc.random64( state, i, 100, 200 )
assert( like( v, 100 + (state[i-2]*67108864+state[i-1])%(200-100)))
v, state, i = Cmwc.random64( state, i, 100, 100 )
assert( like( v, 100 ))
assert( not pcall( Cmwc.random64, state, i, 1, 0 ))

v, state, i = Cmwc.random6
