-- core/utils.lua
-- Utility functions for math, tables, logging, and common operations
-- These are stateless helper functions used throughout the codebase

local Utils = {}

-- ===== MATH UTILITIES =====

--- Clamps a value between min and max
function Utils.clamp(value, min, max)
    if value < min then return min end
    if value > max then return max end
    return value
end

--- Linear interpolation between two values
function Utils.lerp(a, b, t)
    return a + (b - a) * t
end

--- Distance between two points
function Utils.distance(x1, y1, x2, y2)
    local dx = x2 - x1
    local dy = y2 - y1
    return math.sqrt(dx * dx + dy * dy)
end

--- Check if a point is within a rectangle
function Utils.pointInRect(px, py, rx, ry, rw, rh)
    return px >= rx and px <= rx + rw and py >= ry and py <= ry + rh
end

--- Rounds a number to nearest integer
function Utils.round(value)
    return math.floor(value + 0.5)
end

--- Rounds down to nearest integer
function Utils.floor(value)
    return math.floor(value)
end

--- Rounds up to nearest integer
function Utils.ceil(value)
    return math.ceil(value)
end

--- Check if a value is approximately equal (useful for float comparisons)
function Utils.approxEqual(a, b, epsilon)
    epsilon = epsilon or 0.0001
    return math.abs(a - b) < epsilon
end

-- ===== TABLE UTILITIES =====

--- Deeply copy a table
function Utils.deepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[Utils.deepCopy(orig_key)] = Utils.deepCopy(orig_value)
        end
        setmetatable(copy, Utils.deepCopy(getmetatable(orig)))
    else
        copy = orig
    end
    return copy
end

--- Merge two tables (shallow copy, second table overwrites first)
function Utils.mergeTables(t1, t2)
    local result = Utils.deepCopy(t1)
    if t2 then
        for k, v in pairs(t2) do
            result[k] = v
        end
    end
    return result
end

--- Check if a table contains a value
function Utils.tableContains(tbl, value)
    for _, v in ipairs(tbl) do
        if v == value then
            return true
        end
    end
    return false
end

--- Get the size of a table (works for both array and map tables)
function Utils.tableSize(tbl)
    local count = 0
    for _ in pairs(tbl) do
        count = count + 1
    end
    return count
end

--- Get all keys from a table
function Utils.tableKeys(tbl)
    local keys = {}
    for k in pairs(tbl) do
        table.insert(keys, k)
    end
    return keys
end

--- Get all values from a table
function Utils.tableValues(tbl)
    local values = {}
    for _, v in pairs(tbl) do
        table.insert(values, v)
    end
    return values
end

--- Find the first element in a table that matches a predicate
function Utils.tableFind(tbl, predicate)
    for _, v in ipairs(tbl) do
        if predicate(v) then
            return v
        end
    end
    return nil
end

--- Filter a table using a predicate function
function Utils.tableFilter(tbl, predicate)
    local result = {}
    for _, v in ipairs(tbl) do
        if predicate(v) then
            table.insert(result, v)
        end
    end
    return result
end

--- Map a function over all elements in a table
function Utils.tableMap(tbl, func)
    local result = {}
    for i, v in ipairs(tbl) do
        result[i] = func(v, i)
    end
    return result
end

-- ===== STRING UTILITIES =====

--- Split a string by a delimiter
function Utils.stringSplit(str, delimiter)
    local result = {}
    local pattern = string.format("([^%s]+)", delimiter)
    str:gsub(pattern, function(c)
        table.insert(result, c)
    end)
    return result
end

--- Trim whitespace from a string
function Utils.stringTrim(str)
    return str:match("^%s*(.-)%s*$")
end

--- Capitalize first letter of string
function Utils.stringCapitalize(str)
    return str:sub(1, 1):upper() .. str:sub(2):lower()
end

--- Format a number with thousand separators
function Utils.formatNumber(num)
    local formatted = tostring(num)
    local k
    while true do
        formatted, k = formatted:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
        if k == 0 then break end
    end
    return formatted
end

-- ===== LOGGING UTILITIES =====

local LOG_LEVELS = {
    DEBUG = 0,
    INFO = 1,
    WARN = 2,
    ERROR = 3,
}

Utils.currentLogLevel = LOG_LEVELS.INFO

--- Set the current log level
function Utils.setLogLevel(level)
    if LOG_LEVELS[level] then
        Utils.currentLogLevel = LOG_LEVELS[level]
    end
end

--- Log a debug message
function Utils.log(message, level)
    level = level or "INFO"
    if LOG_LEVELS[level] and LOG_LEVELS[level] >= Utils.currentLogLevel then
        local timestamp = os.date("%H:%M:%S")
        print(string.format("[%s] [%s] %s", timestamp, level, tostring(message)))
    end
end

--- Log an info message
function Utils.info(message)
    Utils.log(message, "INFO")
end

--- Log a warning message
function Utils.warn(message)
    Utils.log(message, "WARN")
end

--- Log an error message
function Utils.error(message)
    Utils.log(message, "ERROR")
end

--- Assert with custom message
function Utils.assert(condition, message)
    if not condition then
        Utils.error("Assertion failed: " .. (message or "unknown error"))
        error(message or "Assertion failed")
    end
end

-- ===== RANDOMIZATION UTILITIES =====

--- Random integer between min and max (inclusive)
function Utils.randomInt(min, max)
    return math.floor(math.random() * (max - min + 1)) + min
end

--- Random float between min and max
function Utils.randomFloat(min, max)
    return math.random() * (max - min) + min
end

--- Weighted random selection (pass table with {value = weight} pairs)
function Utils.weightedRandom(weights)
    local totalWeight = 0
    for _, weight in pairs(weights) do
        totalWeight = totalWeight + weight
    end
    
    local random = math.random() * totalWeight
    local accumulated = 0
    
    for key, weight in pairs(weights) do
        accumulated = accumulated + weight
        if random <= accumulated then
            return key
        end
    end
    
    return nil  -- Shouldn't reach here
end

--- Shuffle an array in-place
function Utils.shuffle(tbl)
    for i = #tbl, 2, -1 do
        local j = math.random(i)
        tbl[i], tbl[j] = tbl[j], tbl[i]
    end
    return tbl
end

-- ===== COORDINATE UTILITIES =====

--- Convert world coordinates to chunk coordinates
function Utils.worldToChunk(wx, wy, chunkSize)
    return math.floor(wx / chunkSize), math.floor(wy / chunkSize)
end

--- Convert chunk coordinates to world coordinates (returns top-left corner)
function Utils.chunkToWorld(cx, cy, chunkSize)
    return cx * chunkSize, cy * chunkSize
end

--- Convert world coordinates to local chunk coordinates
function Utils.worldToLocal(wx, wy, chunkSize)
    return wx % chunkSize, wy % chunkSize
end

--- Convert pixel coordinates to tile coordinates
function Utils.pixelToTile(px, py, tileSize)
    return math.floor(px / tileSize), math.floor(py / tileSize)
end

--- Convert tile coordinates to pixel coordinates (returns center)
function Utils.tileToPixel(tx, ty, tileSize)
    return tx * tileSize + tileSize / 2, ty * tileSize + tileSize / 2
end

return Utils
