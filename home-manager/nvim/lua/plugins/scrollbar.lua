return {
  {
    "lewis6991/satellite.nvim",
    event = "VeryLazy",
    opts = {
      current_only = false,
      winblend = 0,
      zindex = 40,
      excluded_filetypes = {},
      width = 2,
      handlers = {
        cursor = {
          enable = true,
          symbols = { "⎺", "⎻", "⎼", "⎽" },
          -- Highlights:
          -- - SatelliteCursor (default links to NonText)
        },
        search = {
          enable = true,
          -- Highlights:
          -- - SatelliteSearch (default links to Search)
          -- - SatelliteSearchCurrent (default links to SearchCurrent)
        },
        diagnostic = {
          enable = true,
          signs = { "-", "=", "≡" },
          min_severity = vim.diagnostic.severity.HINT,
          -- Highlights:
          -- - SatelliteDiagnosticError (default links to DiagnosticError)
          -- - SatelliteDiagnosticWarn  (default links to DiagnosticWarn)
          -- - SatelliteDiagnosticInfo  (default links to DiagnosticInfo)
          -- - SatelliteDiagnosticHint  (default links to DiagnosticHint)
        },
        gitsigns = {
          enable = true,
          signs = {
            add = "│",
            change = "│",
            delete = "-",
          },
          -- Highlights:
          -- - SatelliteGitSignsAdd    (default links to GitSignsAdd)
          -- - SatelliteGitSignsChange (default links to GitSignsChange)
          -- - SatelliteGitSignsDelete (default links to GitSignsDelete)
        },
        marks = {
          enable = true,
          show_builtins = false,
          key = "m",
          -- Highlights:
          -- - SatelliteMark (default links to Normal)
        },
        quickfix = {
          signs = { "-", "=", "≡" },
          -- Highlights:
          -- - SatelliteQuickfix (default links to WarningMsg)
        },
      },
    },
    config = function(_, opts)
      require("satellite").setup(opts)

      -- Optional: make Satellite highlights “follow” TokyoNight / your colorscheme.
      -- This uses links to existing highlight groups (safe + theme-friendly).
      local function set_satellite_highlights()
        local set = vim.api.nvim_set_hl

        -- core
        set(0, "SatelliteCursor", { link = "CursorLine" })
        set(0, "SatelliteSearch", { link = "Search" })
        set(0, "SatelliteSearchCurrent", { link = "IncSearch" }) -- or "Search" if you prefer

        -- diagnostics
        set(0, "SatelliteDiagnosticError", { link = "DiagnosticError" })
        set(0, "SatelliteDiagnosticWarn", { link = "DiagnosticWarn" })
        set(0, "SatelliteDiagnosticInfo", { link = "DiagnosticInfo" })
        set(0, "SatelliteDiagnosticHint", { link = "DiagnosticHint" })

        -- git (these assume you use gitsigns)
        set(0, "SatelliteGitSignsAdd", { link = "GitSignsAdd" })
        set(0, "SatelliteGitSignsChange", { link = "GitSignsChange" })
        set(0, "SatelliteGitSignsDelete", { link = "GitSignsDelete" })

        -- marks / quickfix
        set(0, "SatelliteMark", { link = "Normal" })
        set(0, "SatelliteQuickfix", { link = "WarningMsg" })

        -- bar background: “transparent” look via blending against Normal
        set(0, "SatelliteBar", { link = "Normal" })
        -- if your version has it, keep consistent:
        set(0, "SatelliteBackground", { link = "Normal" })
      end
      -- Apply now and whenever the colorscheme changes (e.g. tokyonight reload)
      set_satellite_highlights()
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_satellite_highlights,
      })
    end,
  },
}
