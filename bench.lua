local Cmwc = require('cmwc')
local crandom = Cmwc.random
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
local qc, i, c = Cmwc.make()
local t = os.clock()
for j = 1, N do
	qc, x = crandom( qc )
end
local t2 = os.clock() - t
print( 'PCMWC', N / t2, 'OP/S' )

print( 'Performance drop x', t2 / t1 )

