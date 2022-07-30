--------------
-- Aliases  --
--------------

local cmd = vim.cmd
local fn  = vim.fn
local g   = vim.g
local map = vim.api.nvim_set_keymap
local o   = vim.opt


--------------
-- Options  --
--------------

-- Notes
-- use :help <command> to learn about a command
-- EX: :help number
-- use :q to quit the menu that popped up

o.completeopt    = 'menuone,noinsert,noselect'
o.cursorline     = true
o.number         = true
o.relativenumber = true
o.scrolloff      = 5
-- let mapleader = "\<SPACE>"
o.timeoutlen     = 10000
o.colorcolumn    = "80"
o.wildmenu       = true
o.expandtab      = true
o.shiftwidth     = 4
o.autoindent     = true
o.signcolumn     = "yes"
o.showmode       = true
o.splitbelow     = true
o.splitright     = true


---------------
-- Mappings  --
---------------

-- Notes
-- Leader keys are where you press one key than another
-- which seems like everything in vim
-- however many commands also require using Ctrl <C>
-- This is implementing many of these with space as a leader key instead
-- like spacevim

g.mapleader = " "

--splits
map('n', '<LEADER>wv', ':vsplit<CR>', {noremap = true})
map('n', '<LEADER>ws', ':split<CR>', {noremap = true})
map('n', '<LEADER>wh', '<C-w>h', {noremap = true})
map('n', '<LEADER>wj', '<C-w>j', {noremap = true})
map('n', '<LEADER>wk', '<C-w>k', {noremap = true})
map('n', '<LEADER>wl', '<C-w>l', {noremap = true})

-- general
map('n', '<LEADER>wq', ':wq<CR>', {noremap = true})
map('n', '<LEADER>fs', ':w<CR>', {noremap = true})
map('n', '<LEADER>a',  ':', {noremap = true})
map('n', '<LEADER>yy', '"+yy', {noremap = true})
map('n', '<LEADER>pp', '"+p', {noremap = true})
map('n', 'U', '<C-r>', {noremap = true})

-- tabs
map('n', '<LEADER>tn', ':tabf %<CR>', {noremap = true})
map('n', '<LEADER>tk', ':tabn<CR>', {noremap = true})
map('n', '<LEADER>tj', ':tabj<CR>', {noremap = true})
map('n', '<LEADER>tc', ':tabc<CR>', {noremap = true})


--------------
-- Plugins  --
--------------

let g:ale_fix_on_save = 1
