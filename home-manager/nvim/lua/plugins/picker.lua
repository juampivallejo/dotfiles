return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      win = {
        input = {
          keys = {
            ["<a-.>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<a-,>"] = { "toggle_ignored", mode = { "i", "n" } },
            ["<a-g>"] = { "toggle_live", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            ["<a-.>"] = { "toggle_hidden", mode = { "i", "n" } },
            ["<a-,>"] = { "toggle_ignored", mode = { "i", "n" } },
            ["<a-g>"] = { "toggle_live", mode = { "i", "n" } },
          },
        },
      },
    },
  },
}
