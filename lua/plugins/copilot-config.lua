-- lua/plugins/copilot.lua
return {
  "zbirenbaum/copilot.lua",
  enabled = false,
  keys = {
    {
      "<leader>at",
      function()
        if require("copilot.client").is_disabled() then
          require("copilot.command").enable()
        else
          require("copilot.command").disable()
        end
      end,
      -- LazyVim toggle does not work, but status line has an Icon when enabled at right bottom
      desc = "Toggle (Copilot)",
    },
  },
}
