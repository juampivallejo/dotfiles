-- lua/config/util.lua
local M = {}

function M.hostname()
  local uv = vim.uv or vim.loop
  if uv and uv.os_gethostname then
    return uv.os_gethostname()
  end
  if uv and uv.gethostname then
    return uv.gethostname()
  end
  return vim.fn.hostname()
end

function M.is_mac()
  return (vim.loop.os_uname().sysname == "Darwin")
end
function M.is_host(pat)
  return M.hostname():match(pat) ~= nil
end

return M
