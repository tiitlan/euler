#!/usr/bin/env lua

--[[
Print the prime factors of a large number, separated by tabs.
Stores all the primes it needs in file primes.txt located in the same directory as this file.
]]

require 'primes'

-- Print usage, exit with error
function usage()
	io.stderr:write('Usage: factorize.lua <number>')
	os.exit(2)
end

function table.print(t)
	local out = io.stdout
	for i,v in ipairs(t) do
		out:write(v, (i < #t) and ', ' or '')
	end
	out:write('\n')
end

-- Script BEGINS
if #arg ~= 1 then usage() end
local n = tonumber(arg[1], 10)
local factors = {primes.factorize(n)}
if #factors == 1 then
	print("It's a prime, silly!")
else
	table.print(factors)
end
primes.store()
