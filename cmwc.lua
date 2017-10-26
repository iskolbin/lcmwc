local floor = math.floor

local Cmwc = {}

local zeros4097 = (function()
	local t = {}
	for i = 1, 4097 do t[i] = 0 end
	return (loadstring or load)( 'return {' .. table.concat( t, ',' ) .. '}' )
end)()

function Cmwc.make( c )
	local qc = zeros4097()
	c = c or 433494437
	for i = 1, 4097 do
		c = c * 129749
		c = c % 0x100000000
		c = c * 8505
		c = c + 12345
		c = c % 0x100000000
		qc[i] = c
	end
	qc[4097] = c % 809430660
	return qc, 1
end

local function nextstate( qc, i )
	if i < 4096 then
		return qc, i + 1
	else
		local qc, c = qc, qc[4097]
		local newqc = zeros4097()
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
		newqc[4097] = c
		return newqc, 1
	end
end

function Cmwc.random( qc, i, min, max )
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

return Cmwc
