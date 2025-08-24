local env = require("utils.env")
return {
  "olimorris/codecompanion.nvim",
  enabled = function()
    return not env.is_mac()
  end,
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
