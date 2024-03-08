local opts = {
  -- Event to trigger linters
  events = { "BufWritePost", "BufReadPost", "InsertLeave" },
  linters_by_ft = {
    -- python = { "mypy" },
    -- Use the "*" filetype to run linters on all filetypes.
    -- ['*'] = { 'global linter' },
    -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
    -- ['_'] = { 'fallback linter' },
  },
}
return {
  "mfussenegger/nvim-lint",
  opts = opts,
}
