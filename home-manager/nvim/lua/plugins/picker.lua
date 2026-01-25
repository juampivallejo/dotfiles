return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      win = {
        input = {
          keys = {
            ["\\l"] = "toggle_live",
            ["\\h"] = "toggle_hidden",
            ["\\i"] = "toggle_ignored",
            ["\\m"] = "toggle_maximize",
            ["\\p"] = "toggle_preview",
            ["\\f"] = "toggle_follow",
            ["\\d"] = "inspect",
            ["\\g"] = "print_path",
            ["<c-w>w"] = "cycle_win",
          },
        },
        list = {
          keys = {
            ["\\l"] = "toggle_live",
            ["\\h"] = "toggle_hidden",
            ["\\i"] = "toggle_ignored",
            ["\\m"] = "toggle_maximize",
            ["\\p"] = "toggle_preview",
            ["\\f"] = "toggle_follow",
            ["\\d"] = "inspect",
            ["\\g"] = "print_path",
            ["<c-w>w"] = "cycle_win",
          },
        },
      },
    },
  },
}
