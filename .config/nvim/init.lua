-- ~/.config/nvim/init.lua

vim.opt.compatible = false

vim.opt.runtimepath:prepend(vim.fn.expand("~/.vim"))
vim.opt.runtimepath:append(vim.fn.expand("~/.vim/after"))
vim.opt.packpath = vim.opt.runtimepath:get()

vim.g.one_allow_italics = 1
vim.cmd.source(vim.fn.expand("~/.vimrc"))

local uv = vim.uv or vim.loop
local theme_file = vim.fn.expand("~/SYSTEM_THEME")

vim.opt.termguicolors = true
vim.opt.runtimepath:prepend(vim.fn.expand("~/.vim"))

local function apply_theme()
  local f = io.open(theme_file, "r")
  if not f then return end

  local theme = vim.trim(f:read("*l") or "")
  f:close()

  if theme ~= "dark" and theme ~= "light" then return end

  -- vim-one expects background after loading
  vim.o.background = theme

  -- Load ~/.vim/colors/one.vim
  -- vim.cmd("runtime colors/one.vim")
  vim.cmd("source " .. vim.fn.fnameescape(vim.fn.expand("~/.vim/colors/one.vim")))

  vim.cmd("redraw!")
  local highlight_groups = { "Normal", "NonText", "LineNr", "SignColumn", "EndOfBuffer", "NormalFloat" }
  for _, group in ipairs(highlight_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
  end

end

apply_theme()

local sigusr1 = uv.new_signal()
sigusr1:start("sigusr1", function()
  vim.schedule(apply_theme)
end)

require("config.lazy")

vim.diagnostic.config({
  virtual_text = true, -- Show small hints at the end of the line
  signs = true,        -- Show symbols in the gutter
  update_in_insert = false,
  underline = true,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded", -- Adds a nice box around the popup
    source = "always",  -- Shows "shellcheck" so you know where the error is from
    header = "",
    prefix = "",
  },
})

vim.keymap.set('n', 'gl', vim.diagnostic.open_float)

local highlight_groups = { "Normal", "NonText", "LineNr", "SignColumn", "EndOfBuffer", "NormalFloat" }
for _, group in ipairs(highlight_groups) do
    vim.api.nvim_set_hl(0, group, { bg = "none", ctermbg = "none" })
end

