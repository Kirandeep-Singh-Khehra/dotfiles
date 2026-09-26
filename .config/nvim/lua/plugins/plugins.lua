return {
  --     {
  --   "folke/tokyonight.nvim",
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     -- load the colorscheme here
  --     vim.cmd([[colorscheme tokyonight]])
  --   end,
  -- },
    -- if some code requires a module from an unloaded plugin, it will be automatically loaded.
    -- So for api plugins like devicons, we can always set lazy=true
    { "nvim-tree/nvim-web-devicons", lazy = true },
    {
        'pablos123/shellcheck.nvim',
        config = function () require 'shellcheck-nvim'.setup {} end
    },
    {
        "mfussenegger/nvim-lint",
        config = function()
            local lint = require("lint")

            lint.linters.clang = {
                cmd = "clang-19",
                stdin = false,
                append_fname = true,
                args = {
                    "-fsyntax-only",
                    "-Wall",
                    "-Wextra",
                },
                stream = "stderr",
                ignore_exitcode = true,
                parser = require("lint.parser").from_pattern(
                    "([^:]+):(%d+):(%d+): (%w+): (.+)",
                    { "file", "lnum", "col", "severity", "message" },
                    {
                        error = vim.diagnostic.severity.ERROR,
                        warning = vim.diagnostic.severity.WARN,
                        note = vim.diagnostic.severity.INFO,
                    },
                    { source = "clang" }
                ),
            }

            lint.linters_by_ft = {
                dockerfile = { "hadolint" },
                c = { "clang" },
            }

            vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
                callback = function()
                    lint.try_lint()
                end,
            })
        end,
    }
}
