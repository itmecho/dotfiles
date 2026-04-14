local M = {}

local function parseHex(hex)
  local trimmed = hex:gsub('^#', '')
  if #trimmed ~= 6 then
    error("expected 6 characters in hex code, got '"..trimmed.."'")
  end

  local r = tonumber(trimmed:sub(0,2), 16)
  local g = tonumber(trimmed:sub(3,4), 16)
  local b = tonumber(trimmed:sub(5,6), 16)

  return r, g, b
end

function M.hexToRGB(hex, alpha)
  local r, g, b = parseHex(hex)

  if alpha ~= nil then
    return string.format("rgba(%d, %d, %d, %s)", r, g, b, alpha)
  end

  return string.format("rgb(%d, %d, %d)", r, g, b)
end

return M
