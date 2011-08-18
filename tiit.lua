--[[
A diverse set of utility functions.
]]

-- Clone a table, one level deep, no metadata
function table.copy(t)
	local retval = {}
	for i,v in ipairs(t) do
		retval[i] = v
	end
	return retval
end

-- Limit an iterator to a certain number of iterations
function limit(maker, n)
    local i = 0
    local iter = maker()
    return function ()
        i = i + 1
        return (i <= n) and iter() or nil
    end
end

-- Write debug output
function trace(...)
	for i,v in ipairs(arg) do
		local t = type(v)
		if t == 'string' or t == 'number' or t == 'boolean' then io.stderr:write(v)
		elseif t == 'table' then io.stderr:write('{', table.concat(v, ','), '}')
		else io.stderr:write('[something]')
		end
	end
	io.stderr:write('\n');
end
