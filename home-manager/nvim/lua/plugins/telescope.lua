return {
  "telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  keys = {
    {
      "<leader>fF",
      function()
        require("telescope.builtin").find_files({ no_ignore = true })
      end,
      desc = "Find files (ignored)",
    },
    {
      "<leader>r",
      function()
        require("telescope.builtin").resume({})
      end,
      desc = "Resume search",
    },
    {
      "<leader>xr",
      function()
        require("telescope.builtin").quickfix({})
      end,
      desc = "Telescope quickfix",
    },
    {
      "<leader>xs",
      function()
        require("telescope.builtin").spell_suggest({})
      end,
      desc = "Spell Suggestions",
    },
  },
}
