local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import any extras modules here
    -- { import = "lazyvim.plugins.extras.lang.typescript" },
    -- { import = "lazyvim.plugins.extras.ui.mini-animate" },

    -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
    -- TODO: Fix missing json lsp package on nixos
    -- It is imported with as vscode-json-languageserver instead of vscode-json-language-server
    -- { import = "lazyvim.plugins.extras.lang.json" },

    -- Blink completions
    { import = "lazyvim.plugins.extras.coding.blink" },
    -- add none-ls extra for Cspell
    { import = "lazyvim.plugins.extras.lsp.none-ls" },
    -- Add Rest extra
    { import = "lazyvim.plugins.extras.util.rest" },

    -- NeoTest extra
    { import = "lazyvim.plugins.extras.test.core" },
    -- DAP: ../plugins/dap.lua used instead because of issues with Mason
    -- { import = "lazyvim.plugins.extras.dap.core" },

    -- Copilot and Chat
    -- { import = "lazyvim.plugins.extras.ai.copilot" },
    -- { import = "lazyvim.plugins.extras.ai.copilot-chat" },

    -- Editor testing
    { import = "lazyvim.plugins.extras.editor.snacks_picker" },
    { import = "lazyvim.plugins.extras.editor.snacks_explorer" },

    -- Rust
    { import = "lazyvim.plugins.extras.lang.rust" },

    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
