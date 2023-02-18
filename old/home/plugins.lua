-- gotten basic structure from
-- https://gitlab.com/drishal/dotfiles/-/blob/master/config/nvim/plugins.lua
--
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    use { 'ShinKage/idris2-nvim', requires = { 'neovim/nvim-lspconfig', 'MunifTanjim/nui.nvim' } }
end)
