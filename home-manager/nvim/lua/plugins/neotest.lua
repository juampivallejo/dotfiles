-- Config for LazyVim Extras neotest code
return {
  { "nvim-neotest/neotest-python" },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "nvim-neotest/neotest-python",
    },
    opts = {
      adapters = {
        ["neotest-python"] = {
          -- Here you can specify the settings for the adapter, i.e.
          runner = "pytest",
        },
      },
      summary = {
        open = "topleft vsplit | vertical resize 50",
      },
    },
  },
}
