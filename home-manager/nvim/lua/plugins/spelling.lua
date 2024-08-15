return {
  {
    -- IMPORTANT: cspell must be properly installed (e.g. use npm and verify it can run on cli)
    "davidmh/cspell.nvim",
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "davidmh/cspell.nvim" },
    opts = function(_, opts)
      local cspell = require("cspell")
      local config = {
        cspell_config_dirs = { "~/.config/" },
        -- Includes:
        -- payload.new_word
        -- payload.cspell_config_path
        -- payload.generator_params
        -- For example, you can format the cspell config file after you add a word
        on_add_to_json = function(payload)
            os.execute(
                string.format(
                    "jq -S '.words |= sort' %s > %s.tmp && mv %s.tmp %s",
                    payload.cspell_config_path,
                    payload.cspell_config_path,
                    payload.cspell_config_path,
                    payload.cspell_config_path
                )
            )
        end,
        ---@param payload AddToDictionarySuccess
        on_add_to_dictionary = function(payload)
            -- Includes:
            -- payload.new_word
            -- payload.cspell_config_path
            -- payload.generator_params
            -- payload.dictionary_path
            -- For example, you can sort the dictionary after adding a word
            os.execute(
                string.format(
                    "sort %s -o %s",
                    payload.dictionary_path,
                    payload.dictionary_path
                )
            )
        end
      }
      table.insert(opts.sources, cspell.diagnostics.with({ config = config }))
      table.insert(opts.sources, cspell.code_actions.with({ config = config }))
      opts.fallback_severity = vim.diagnostic.severity.HINT
    end,
  },
}
