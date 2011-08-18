#!/usr/bin/env lua

--[[
A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
    a^2 + b^2 = c^2
For example, 32 + 42 = 9 + 16 = 25 = 52.
There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product a*b*c.
]]

-- In the following, we will need the squares of all possible values of a, b, and c.
sq = {}
for i = 1,998 do
    sq[i] = i^2
end

-- Generate all valid combinations of a and b, check if c can be chosen accordingly
for a = 1,499 do
    for b = a+1,1000-a-1 do
        local c = 1000 - a - b
        if sq[a] + sq[b] == sq[c] then
            print(string.format("a=%d, b=%d, c=%d, a*b*c=%d\n", a, b, c, a*b*c))
            break
        end
    end
end
