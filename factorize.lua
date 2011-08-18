#!/usr/bin/env lua

--[[
Print the prime factors of a large number, separated by tabs.
Stores all the primes it needs in file primes.txt located in the same directory as this file.
]]

require 'tiit'

-- Here be all the known primes, in ascending order
PRIMES = {2, 3, 5, 7, 11}
PRIMES_FILE = 'primes.txt'

-- Did we add any new primes in this run?
DIRTY = false

-- Load primes from primes.txt into PRIMES
function load_primes()
	PRIMF = io.open(PRIMES_FILE, 'r')
	if not PRIMF then return end
	local oldprimes = table.copy(PRIMES)
	local i = 1
	for line in PRIMF:lines() do
		PRIMES[i] = tonumber(line, 10)
		i = i + 1
	end
	-- Quick sanity check
	if #PRIMES < #oldprimes then PRIMES = table.copy(oldprimes) end

	PRIMF:close()
end

-- Store primes from PRIMES back into primes.txt
function store_primes()
	if not DIRTY then return end
	PRIMF = io.open(PRIMES_FILE, 'w')
	for i,p in ipairs(PRIMES) do PRIMF:write(p, '\n') end
	PRIMF:close()
end

-- Append `x' to the table `t'
function append(x, t)
	t[#t+1] = x
	return x
end

-- Find the next largest prime, store it in `PRIMES', and return.
function next_prime()
	-- Iterate over odd numbers until we hit a prime.
	local p = PRIMES[#PRIMES] + 2
	while not is_prime(p) do p = p + 2 end

	-- Bingo! Cache it and we're done.
	--trace(string.format('next_prime: %u=%u\n', #PRIMES+1, p))
	DIRTY = true
	return append(p, PRIMES)
end

-- Is `x' a divisor of ´y'?
function is_divisor(x, y)
	return y % x == 0
end

-- Is `x' a prime?
function is_prime(x)
	local vx = math.floor(math.sqrt(x))
	local i = 1
	while PRIMES[i] <= vx do
		if is_divisor(PRIMES[i], x) then return false end
		i = i + 1
		if i > #PRIMES then next_prime() end
	end
	return true
end

-- Return all the prime factors of `n'
function factorize(n)
	local vn = math.floor(math.sqrt(n))
	--trace('factorize: Iterating up to ', vn)
	local i = 1
	local retval = {}
	while PRIMES[i] <= vn do
		if is_divisor(PRIMES[i], n) then
			append(PRIMES[i], retval)
			--trace('Prime ', PRIMES[i], ' is a facor')
			local q = n / PRIMES[i]
			if is_prime(q) then append(q, retval) end
		end
		i = i + 1
		if i > #PRIMES then next_prime() end
	end
	table.sort(retval)
	return unpack(retval)
end

-- Print usage, exit with error
function usage()
	io.stderr:write('Usage: factorize.lua <number>')
	os.exit(2)
end

-- Script BEGINS
if #arg ~= 1 then usage() end
load_primes()
local n = tonumber(arg[1], 10)
--local result = factorize(tonumber(arg[1], 10))
--trace('factorize(', n, ') = ', result)
print(factorize(n))
store_primes()
