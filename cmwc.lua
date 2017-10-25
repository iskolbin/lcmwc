local floor = math.floor

local Cmwc = {}

function Cmwc.make( seed )
	local qc, c = {}, seed or 42
	for i = 1, 4096 do
		c = c * 129749
		c = c % 0x100000000
		c = c * 8505
		c = c + 12345
		c = c % 0x100000000
		qc[i] = c
	end
	c = c * 129749
	c = c % 0x100000000
	c = c * 8505
	c = c + 12345
	c = c % 0x100000000
	c = c % 809430660
	return { qc = qc, i = 1, c = c }
end

local zeros4096 = (function()
	local t = {}
	for i = 1, 4096 do t[i] = 0 end
	return (loadstring or load)( 'return {' .. table.concat( t, ',' ) .. '}' )
end)()

local function nextState( self )
	local i = self.i
	if i < 4096 then
		return { qc = self.qc, i = i + 1, c = self.c }
	else
		local qc, c = self.qc, self.c
		local newqc = zeros4096()
		for j = 1, 4096 do
			local t = 18782 * qc[j] + c
			c = floor( t / 4294967296 )
			local x = (t + c) % 0x100000000
			if x < c then
				x, c = x + 1, c + 1
			end
			if x == 0xffffffff then
				x, c = 0, c + 1
			end
			local q = 0xfffffffe - x
			if  q < 0 then
				q = q + 0x100000000
			end
			newqc[j] = q
		end
		return { qc = newqc, i = 1, c = c }
	end
end

function Cmwc.random( self, min, max )
	if max == nil then
		if min == nil then
			return nextState( self ), self.qc[self.i] / 4294967296.0
		elseif min >= 1 then
			return nextState( self ), self.qc[self.i] % floor( min ) + 1
		else
			error( 'bad argument #1 to \'random\' (interval is empty)' )
		end
	else
		if min < max then
			return nextState( self ), self.qc[self.i] % floor( max - min ) + min
		elseif min == max then
			return nextState( self ), min
		else
			error( 'bad argument #2 to \'random\' (interval is empty)' )
		end
	end
end

return Cmwc
