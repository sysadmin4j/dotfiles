-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.conceallevel = 0
vim.opt.spell = false
vim.opt.wrap = false

-- https://github.com/echasnovski/mini.nvim/blob/main/doc/mini-pairs.txt
-- disable the mini.pairs plugin
-- https://www.lazyvim.org/keymaps#minipairs
-- to enable it within lazyvim <Leader>up
vim.g.minipairs_disable = true

-- https://github.com/iamcco/markdown-preview.nvim?tab=readme-ov-file#markdownpreview-config
-- markdownpreview plugin configuration
vim.g.mkdp_page_title = "${name}"
vim.g.mkdp_theme = "dark"

--[[

-- for lsp debugging
vim.lsp.set_log_level("info")

-- for clipboard debugging
vim.g.clipboard = {
    name = 'myClipboard',
    copy = {
        ['+'] = 'cb copy',
        ['*'] = 'cb copy',
    },
    paste = {
        ['+'] = 'cb paste',
        ['*'] = 'cb paste',
    },
    cache_enabled = 0,
}
vim.opt.clipboard = "unnamedplus"

]]
--
