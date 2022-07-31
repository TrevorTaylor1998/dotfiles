-------------
-- require --
-------------

require("toggleterm").setup {}
require 'hop'.setup()

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
-- o.termgui        = true


---------------
-- Mappings  --
---------------

-- Notes
-- Leader keys are where you press one key than another
-- which seems like everything in vim
-- however many commands also require using Ctrl <C>
-- This is implementing many of these with space as a leader key instead
-- like spacevim
--
-- w for windows
-- t for tabs and terminal
-- f for file

g.mapleader = " "

--splits
map('n', '<LEADER>wv', ':vsplit<CR>', { noremap = true })
map('n', '<LEADER>ws', ':split<CR>', { noremap = true })
map('n', '<LEADER>wh', '<C-w>h', { noremap = true })
map('n', '<LEADER>wj', '<C-w>j', { noremap = true })
map('n', '<LEADER>wk', '<C-w>k', { noremap = true })
map('n', '<LEADER>wl', '<C-w>l', { noremap = true })
map('n', '<LEADER>wd', ':q<CR>', { noremap = true })
map('n', '<C-h>', '<C-w>h', { noremap = true })
map('n', '<C-j>', '<C-w>j', { noremap = true })
map('n', '<C-k>', '<C-w>k', { noremap = true })
map('n', '<C-l>', '<C-w>l', { noremap = true })

-- general
map('n', '<LEADER>wq', ':wq<CR>', { noremap = true })
map('n', '<LEADER>fs', ':w<CR>', { noremap = true })
map('n', '<LEADER>a', ':', { noremap = true })
map('n', '<LEADER>yy', '"+yy', { noremap = true })
map('n', '<LEADER>pp', '"+p', { noremap = true })
map('n', 'U', '<C-r>', { noremap = true })
map('i', 'kj', '<esc>', { noremap = true })
-- technically set later on but this is more direct
-- saves one blink of ourside boarder
map('n', '-', ':RnvimrToggle<CR>', { noremap = true })
map('n', '<LEADER>.', ':RnvimrToggle<CR>', { noremap = true })

-- coding
map('n', '<LEADER>fc', ':luafile %<CR>', { noremap = true })

-- tabs
map('n', '<LEADER>tn', ':tabf %<CR>', { noremap = true })
map('n', '<LEADER>tk', ':tabn<CR>', { noremap = true })
map('n', '<LEADER>tj', ':tabp<CR>', { noremap = true })
map('n', '<LEADER>td', ':tabc<CR>', { noremap = true })

-- terminal
map('n', '<LEADER>ts', ':ToggleTerm direction=horizontal<CR>', { noremap = true })
map('n', '<LEADER>tv', ':ToggleTerm direction=vertical size=81<CR>', { noremap = true })
map('n', '<LEADER>tf', ':ToggleTerm direction=float<CR>', { noremap = true })
map('n', '<LEADER>tt', ':ToggleTerm<CR>', { noremap = true })

--------------
-- Plugins  --
--------------


-- colorscheme
-- vim.cmd('colorscheme base16-papercolor-dark')
-- pywal is broken rn
-- local pywal = require('pywal')
-- pywal.setup()

-- shade vim
-- require'shade'.setup({
--   overlay_opacity = 50,
--   opacity_step = 1,
--   keys = {
--     brightness_up    = '<C-Up>',
--     brightness_down  = '<C-Down>',
--     toggle           = '<Leader>s',
--   }
-- })


-- hop
-- hop to beginning of word
keys = { keys = 'asdfghjkl;' }
vim.api.nvim_set_keymap('', 'f', "<cmd>lua require'hop'.hint_words(keys)<cr>", {})

-- toggleterm

-- keybinds for terminal
function _G.set_terminal_keymaps()
    local opts = { buffer = 0 }
    -- if anyone has a better solution
    -- esc only prevents vim modes in zsh which is not fun 
    -- kj prevents using ranger as a file browser nicely
    -- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<esc><esc>', [[<C-\><C-n>]], opts)
    -- vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
    -- vim.keymap.set('t', 'kj', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- which key
-- local wk = require("which-key")
-- wk.register(mappings, opts)


-- go
-- require('go').setup()

-- rust
-- require('rust-tools').setup()

-- rnvimr
g.rnvimr_enable_ex = 1
g.rnvimr_enable_picker = 1

-----------------
-- Tree Sitter --
-----------------

require 'nvim-treesitter.configs'.setup {
    ensure_installed = { "c", "lua", "rust", "go" },
    sync_install = false,
    auto_install = true,
    ignore_install = { "javascript" },
    highlight = {
        enable = true,

        -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
        -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
        -- the name of the parser)
        -- list of language that will be disabled
        disable = {},
    },
    indent = {
        enable = false,
        disable = {},
    };
    rainbow = {
        enable = true,
        extended_mode = true,
        max_file_lines = nil,
    }
}


--------------
--   LSP    --
--------------


-- autoformatting on save

-- autocmd BufWritePre lua vim.lsp.buf.formatting()
vim.api.nvim_command('autocmd BufWritePre * lua vim.lsp.buf.formatting()')


require("lsp_signature").setup({
    bind = true,
    handler_opts = {
        border = "rounded"
    }
})





-- Generic Setup

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', '<space>k', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', vim.lsp.buf.formatting, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}
require('lspconfig')['pyright'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['sumneko_lua'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
-- formatting does weird stuff
require('lspconfig')['gopls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['rnix'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['rust_analyzer'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    settings = {
        ["rust-analyzer"] = {}
    }
}

----------------
-- Completion --
----------------


local cmp = require("cmp")

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<Tab>'] = function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end,
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
require('lspconfig')['rnix'].setup {
    capabilities = capabilities
}
require('lspconfig')['rust-analyzer'].setup {
    capabilities = capabilities
}
