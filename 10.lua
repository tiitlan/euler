#!/usr/bin/env lua

--[[
Find the sum of all primes below 2 million.
]]

-- Primes.
local p = {2}

-- Integer square root.
local function isqrt(x)
	return math.floor(math.sqrt(x))
end

-- Is `x' a prime?
local function is_prime(x)
	local vx = isqrt(x)
	local i = 1
	while p[i] <= vx do
		if x % p[i] == 0 then return false end
		i = i + 1
	end
	return true
end

local i, s = 1, 2
while i < 2000000 do
    i = i + 2
    if is_prime(i) then
        table.insert(p, i)
        s = s + i
    end
end
print(s)
