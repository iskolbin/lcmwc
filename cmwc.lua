local floor = math.floor

local Cmwc = {}

local zeros4097 = (function()
	return (loadstring or load)( 'return {0' .. (',0'):rep(4096) .. '}' )
end)()

local function nextstate( qc, i, newqc )
	if i < 4096 then
		return qc, i + 1
	else
		local c = qc[4097]
		newqc = newqc or zeros4097()
		for j = 1, 4096 do
			local t = 18782 * qc[j] + c
			c = floor( t / 4294967296 )
			local x = (t + c) % 0x100000000
			if x < c then
				x, c = x + 1, c + 1
			end
			if x > 0xfffffffe then
				newqc[j] = 8589934590 - x
			else
				newqc[j] = 0xfffffffe - x
			end
		end
		newqc[4097] = c
		return newqc, 1
	end
end

function Cmwc.make( seed )
	local qc = zeros4097()
	local c = seed or 433494437
	for i = 1, 4097 do
		c = c * 129749
		c = c % 0x100000000
		c = c * 8505
		c = c + 12345
		c = c % 0x100000000
		qc[i] = c
	end
	qc[4097] = c % 809430660
	return nextstate( qc, 4096, qc )
end

function Cmwc.rand( qc, i )
	return qc[i], nextstate( qc, i )
end

function Cmwc.random32( qc, i, min, max )
	if max == nil then
		if min == nil then
			return qc[i] / 4294967296.0, nextstate( qc, i )
		elseif min >= 1 then
			return qc[i] % floor( min ) + 1, nextstate( qc, i )
		else
			error( 'bad argument #1 to \'random\' (interval is empty)' )
		end
	else
		if min < max then
			return qc[i] % floor( max - min ) + min, nextstate( qc, i )
		elseif min == max then
			return min, nextstate( qc, i )
		else
			error( 'bad argument #2 to \'random\' (interval is empty)' )
		end
	end
end

function Cmwc.random64( qc, i, min, max )
	local a = qc[i]
	qc, i = nextstate( qc, i )
	a, qc, i = (a*67108864.0+qc[i])*(1.0/9007199254740992.0), nextstate( qc, i )
	if max == nil then
		if min == nil then
			return a, qc, i
		elseif min >= 1 then
			return a * floor( min ) + 1, qc, i
		else
			error( 'bad argument #1 to \'random\' (interval is empty)' )
		end
	else
		if min < max then
			return q * floor( max - min ) + min, qc, i
		elseif min == max then
			return min, qc, i
		else
			error( 'bad argument #2 to \'random\' (interval is empty)' )
		end
	end
end

return Cmwc
