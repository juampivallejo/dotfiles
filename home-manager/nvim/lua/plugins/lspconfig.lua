-- Setup LSP Config
local env = require("utils.env")

local servers = {
  basedpyright = { settings = { python = { analysis = { typeCheckingMode = "standard" } } } },
  gopls = {},
  lua_ls = {},
  sqls = {},
}

-- only add nil_ls if not on mac
if not env.is_mac() then
  servers.nil_ls = {}
end

return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    ---@diagnostic disable-next-line: missing-fields
    servers = servers,
  },
}
