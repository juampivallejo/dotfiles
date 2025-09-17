local env = require("utils.env")

local opts = function()
  ---@type conform.setupOpts
  local opts = {
    default_format_opts = {
      timeout_ms = 3000,
      async = false, -- not recommended to change
      quiet = false, -- not recommended to change
      lsp_format = "fallback", -- not recommended to change
    },
    formatters_by_ft = {
      lua = { "stylua" },
      sh = { "shfmt" },
      javascript = { "prettierd" },
      css = { "prettierd" },
      html = { "prettierd" },
      htmldjango = { "djlint" },
      json = { "prettierd" },
      yaml = { "prettierd" },
      markdown = { "prettierd" },
      graphql = { "prettierd" },
      python = { "isort", "ruff_format" },
      go = { "gofmt" },
      nix = { "nixfmt" },
      rust = { "rustfmt" },
      sql = { "sleek" },
    },
    ---@type table<string, conform.FormatterConfigOverride|fun(bufnr: integer): nil|conform.FormatterConfigOverride>
    formatters = {
      injected = { options = { ignore_errors = true } },
      -- # Example of using dprint only when a dprint.json file is present
      -- dprint = {
      --   condition = function(ctx)
      --     return vim.fs.find({ "dprint.json" }, { path = ctx.filename, upward = true })[1]
      --   end,
      -- },
      --
      -- # Example of using shfmt with extra args
      shfmt = {
        prepend_args = { "-i", "2", "-ci" }, -- -i 2 (2 spaces) and --ci (case-indent: switch cases will be indented)
      },
    },
  }
  -- add TypeScript formatter conditionally
  if not env.is_host("juampi-desktop") then
    opts.formatters_by_ft.typescript = { "prettier" }
  end
  return opts
end

return {
  "stevearc/conform.nvim",
  opts = opts(),
}
