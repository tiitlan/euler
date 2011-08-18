#!/usr/bin/env lua

--[[
Find the largest palindromic 6-digit number that is the product of two 3-digit numbers.
]]

-- Generate palindrome numbers, 6 places.
function palindromes6()
    local i, j, k = 9, 9, 10 -- Three leftmost places
    return function ()
        k = k - 1
        if k < 0 then
            k = 9
            j = j - 1
        end
        if j < 0 then
            j = 9
            i = i - 1
        end
        if i < 1 then return nil end
        return make_6places(i, j, k, k, j, i)
    end
end

-- Creates a 6-place number from the list of digits
function make_6places(a5, a4, a3, a2, a1, a0)
    return a5*10^5 + a4*10^4 + a3*10^3 + a2*10^2 + a1*10 + a0
end

-- Find if the given 6-digit number is a product of two 3-digit numbers. Return the numbers, if so.
function productof3(n)
    local vn = math.floor(math.sqrt(n))
    -- 316 is the square root of 100001, there is no point in going lower
    for q = vn,316,-1 do
        local r = n % q
        if r == 0 then
            local q2 = math.floor(n/q)
            if 100 <= q2 and q2 <= 999 then return q, q2 end
        end
    end
    return nil
end

for i in palindromes6() do
    local x1, x2 = productof3(i)
    if x1 ~= nil then
        print(string.format("%d = %d x %d\n", i, x1, x2))
        break
    end
end
