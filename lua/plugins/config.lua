-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      transparent_mode = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = true,
    opts = {
      transparent = true,
      style = "night",
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  -- Configure LazyVim to load catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight",
    },
  },
  -- Make transparent
  -- {
  --   "catppuccin",
  --   opts = {
  --     transparent_background = true,
  --     flavour = "frappe",
  --   },
  -- },
  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    config = true,
  },

  -- add more treesitter parsers
  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "bash",
        "html",
        "htmldjango",
        "http",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "go",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      })
    end,
  },

  -- Blinck autocomplete settings, better keymaps
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        ["<C-e>"] = { "cancel" },
      },
    },
  },

  -- disable mason
  { "williamboman/mason.nvim", enabled = false },
  -- Replace to enable
  -- {
  --   "williamboman/mason.nvim",
  --   opts = {
  --     ensure_installed = {
  --       -- "stylua",
  --       -- "shfmt",
  --       -- "flake8",
  --       -- "pyright",
  --       -- "lua-language-server",
  --     },
  --   },
  -- },

  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
}
