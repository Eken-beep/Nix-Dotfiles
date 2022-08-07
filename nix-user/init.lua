local g = vim.g
local o = vim.o
local opt = vim.opt
local A   = vim.api

-- Settings
o.number = true;
o.updatetime = 200
o.scrolloff = 8

-- Editing settings with tab and similar
o.expandtab = true
o.smarttab = true
o.cindent = true
o.autoindent = true
o.wrap = true
o.textwidth = 300
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = -1

-- Undo and backup settings
o.backup = false
o.writebackup = false
o.undofile = true
o.swapfile = true

o.history = 50

-- leader key
g.mapleader = ' '
g.maplocalleader = ' '

-- Theme
require('lualine').setup()
local ok, _ = pcall(vim.cmd, 'colorscheme base16-monokai')

-- KEYBINDINGS
local function map(m, k, v)
    vim.keymap.set(m, k, v, { silent = true })
end

-- Line navigation in insert mode like emacs
map('i', '<C-E>', '<ESC>A')
map('i', '<C-A>', '<ESC>I')

-- Quicksave & exit
map('n', '<C-q>', ':wq<CR>')
map('n', '<C-S-q>', ':q!<CR>')
map('n', '<C-s>', ':w<CR>')

-- Coc.nvim config that for some reason has to be in vimscript...
vim.cmd([[
" Color hightlight for coc
highlight Pmenu ctermfg=White ctermbg=237
highlight PmenuSel ctermfg=White ctermbg=237
highlight FgCocErrorFloatBgCocFloating ctermfg=59 ctermbg=White guifg=White guibg=59

" Coc tab to trigger completion, vscode like behaviour
" but it failed

]])
