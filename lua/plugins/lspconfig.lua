-- Setup LSP Config

return {
  "neovim/nvim-lspconfig",
  ---@class PluginLspOpts
  opts = {
    ---@type lspconfig.options
    ---@diagnostic disable-next-line: missing-fields
    servers = {
      basedpyright = { settings = { python = { analysis = { typeCheckingMode = "standard" } } } },
      -- ty = {},
      gopls = {},
      lua_ls = {},
      -- nil_ls = {},
      -- rust_analyzer = {},
      -- ts_ls = {},
      sqls = {},
    },
  },
}
