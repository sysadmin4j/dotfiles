-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.conceallevel = 0
vim.opt.spell = false
vim.opt.wrap = false
vim.opt.shell = "zsh"

-- https://github.com/echasnovski/mini.nvim/blob/main/doc/mini-pairs.txt
-- disable the mini.pairs plugin
-- https://www.lazyvim.org/keymaps#minipairs
-- to enable it within lazyvim <Leader>up
vim.g.minipairs_disable = true

-- https://github.com/iamcco/markdown-preview.nvim?tab=readme-ov-file#markdownpreview-config
-- markdownpreview plugin configuration
vim.g.mkdp_page_title = "${name}"
vim.g.mkdp_theme = "dark"

-- disable autoformat
-- to enable it within lazyvim <Leader>uf
vim.g.autoformat = false

-- for lsp debugging
-- vim.lsp.set_log_level("info")

-- default clipboard value set by lazyvim
vim.opt.clipboard = "unnamedplus"

-- for the OSC 52 clipboard configuraion
vim.g.clipboard = {
  name = "OSC 52",
  copy = {
    ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
    ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
  },
  paste = {
    ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
    ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
  },
}

-- when the clipboard is enable, pasting with p create the folllowing error:
-- E353: Nothing in register "
-- remapping p to the default register
if vim.o.clipboard == 'unnamed' or vim.o.clipboard == 'unnamedplus' then
  vim.keymap.set({ "n" }, "p", '""p')
end

-- keymap for testing the clipboard
-- vim.keymap.set('n','z', ':set clipboard=<cr>' )
-- vim.keymap.set('n','Z', ':set clipboard=unnamedplus<cr>' )
