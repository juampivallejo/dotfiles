local env = require("utils.env")
return {
  "olimorris/codecompanion.nvim",
  enabled = true,
  -- enabled = function()
  --   return not env.is_mac()
  -- end,
  opts = {
    interactions = {
      chat = {
        adapter = {
          name = "claude_code",
          model = "opus",
        },
      },
    },
    display = {
      action_palette = {
        provider = "snacks", -- matches your picker setup
      },
      chat = {
        show_token_count = true,
        window = {
          layout = "vertical",
          width = 0.45,
          col = 1,
        },
      },
    },
  },
  keys = {
    { "<leader>aa", "<cmd>CodeCompanionChat Toggle<cr>", desc = "AI Chat Toggle" },
    { "<leader>an", "<cmd>CodeCompanionChat<cr>", desc = "AI New Chat" },
    { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions" },
    { "<leader>ai", "<cmd>CodeCompanion<cr>", mode = { "n", "v" }, desc = "AI Inline" },
    { "<leader>ay", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "AI Add to Chat" },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}
