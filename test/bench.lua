local Cmwc = require('cmwc')
local crandom32 = Cmwc.random32
local crandom64 = Cmwc.random64
local random = math.random
local N = 1e7

print( 'benchmarking persistent CMWC4096 vs builtin math.random' )
local x = 0

collectgarbage()
local t = os.clock()
for i = 1, N do
	x = random()
end
local t1 = os.clock() - t
print( 'Builtin', N / t1, 'OP/S' )

collectgarbage()
local qc, i = Cmwc.make()
local t = os.clock()
for j = 1, N do
	x, qc, i = crandom32( qc, i )
end
local t2 = os.clock() - t
print( 'PCMWC', N / t2, 'OP/S' )
print( 'Performance drop x', t2 / t1 )

collectgarbage()
local qc, i = Cmwc.make()
local t = os.clock()
for j = 1, N do
	x, qc, i = crandom64( qc, i )
end
local t2 = os.clock() - t
print( 'PCMWC64', N / t2, 'OP/S' )
print( 'Performance drop x', t2 / t1 )

