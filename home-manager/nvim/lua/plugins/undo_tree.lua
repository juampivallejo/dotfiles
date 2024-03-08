return {
  "mbbill/undotree",
  keys = {
    { "<leader>uu", "<cmd>UndotreeToggle<cr>", desc = "Undo Tree" },
  },
  config = function()
    require("undotree").setup()
  end,
}
