local SEED, N = ...
local Cmwc = require('cmwc')
local qc, i = Cmwc.make( SEED )
local t = os.clock()
for j = 1, N+1 do
	x, qc, i = Cmwc.rand( qc, i )
	print( ('%d'):format( x ))
end
