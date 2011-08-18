-- INTERFACE
primes = {}

-- Make sure the internal table contains a prime at least as large as `n'.
function primes.ensure(n)
	if not LOADED then load_primes() end
	while PRIMES[#PRIMES] < n do -- TODO: finish
	end
end

-- Return all the prime factors of `n'.
function primes.factorize(n)
	local vn = math.floor(math.sqrt(n))
	primes.ensure(vn)
	local retval ={}
	-- TODO: implement
	return unpack(retval)
end

-- Store primes permanently.
function primes.store()
	if DIRTY then store_primes() end
end

-- IMPLEMENTATION

-- The table containing all the known primes.
local PRIMES = {2, 3, 5, 7, 11}

-- File where primes are stored.
local PRIMES_FILE = 'primes.txt'

-- Have we loaded primes yet?
local LOADED = false

-- Did we generate any new primes during this run?
local DIRTY = false

-- Load primes from primes.txt into PRIMES. Returns number of loaded primes, or 0 and error message.
local function load_primes()
	local f, err = io.open(PRIMES_FILE, 'r')
	if not f then return 0, err end
	PRIMES = {}
	for line in f:lines() do table.insert(PRIMES, tonumber(line, 10)) end
	f:close()
	LOADED = true
	return #PRIMES
end

-- Store primes from PRIMES back into primes.txt
local function store_primes()
	local f = io.open(PRIMES_FILE, 'w')
	for i,p in ipairs(PRIMES) do f:write(p, '\n') end
	f:close()
end

-- Find the next largest prime, store it in `PRIMES', and return.
local function next_prime()
	-- Iterate over odd numbers until we hit a prime.
	local p = PRIMES[#PRIMES] + 2
	while not is_prime(p) do p = p + 2 end

	-- Bingo! Cache it and we're done.
	DIRTY = true
	table.insert(PRIMES, p)
end

-- Is `x' a prime?
local function is_prime(x)
	local vx = math.floor(math.sqrt(x))
	local i = 1
	-- TODO: implement correctly
	while PRIMES[i] <= vx do
		if is_divisor(PRIMES[i], x) then return false end
		i = i + 1
		if i > #PRIMES then next_prime() end
	end
	return true
end
