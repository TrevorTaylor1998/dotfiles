--------------
-- Aliases  -- ------------ local cmd = vim.cmd local fn  = vim.fn
local g   = vim.g
local map = vim.api.nvim_set_keymap
local o   = vim.opt

-------------
-- require --
-------------
g.mapleader = " "
-- g.maplocalleader = ','
require("toggleterm").setup {}
require 'hop'.setup()

vim.o.timeoutlen = 600

-- require("which-key").setup {
--     marks = true;
--     registers = true,
--     spelling = {
--         enabled = true; -- z= to give spelling suggest
--         suggestions = 20;
--     },
-- }

local wk = require("which-key")

wk.register({
    f = {
        name = "+file", -- optional group name
        s = { "<cmd>w<CR>", "Save File" },
        S = { "<cmd>wa<CR>", "Save All Files" },
        q = { "<cmd>q<CR>", "Exit File" },
    },
    w = {
        name = "+window",
        v = { "<cmd>vsplit<CR>", "Vertical Split" },
        s = { "<cmd>split<CR>", "Horizontal Split" },
        h = { "<C-w>h", "Switch to Left Window" },
        j = { "<C-w>j", "Switch to Down Window" },
        k = { "<C-w>k", "Switch to Up Window" },
        l = { "<C-w>l", "Switch to Right Window" },
        d = { "<cmd>q<CR>", "Quit Window" },
        w = { "<C-w><C-w>", "Switch Windows (Cycling)" },
        -- ww = { "<cmd>W3m duckduckgo.com<CR>", "Open Web Wowser (not typo)" },
    },
    W = { "<cmd>W3m duckduckgo.com<CR>", "Open Web Wowser (Not Typo)" },
    b = {
        name = "+buffer",
        n = { "<cmd>bn<CR>", "Next Buffer" },
        p = { "<cmd>bp<CR>", "Prev Buffer" },
        d = { "<cmd>bd<CR>", "Delete Buffer" },
    },
    g = {
        name = "+comment",
        c = { "gcc", "Comment line" },

    },
    i = {
        name = "+idris_code_actions",
    },
    z = {
        name = "(NOTE) Backspace to go up level",
    },


}, { prefix = "<leader>" })

--------------
-- Options  --
--------------

-- Notes
-- use :help <command> to learn about a command
-- EX: :help number
-- use :q to quit the menu that popped up

o.completeopt    = 'menuone,noinsert,noselect'
o.cursorline     = false
o.number         = true
o.relativenumber = true
o.scrolloff      = 5
-- o.timeoutlen     = 10000
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


map('n', 'U', '<C-r>', { noremap = true })
map('i', 'kj', '<esc>', { noremap = true })
map('n', '-', ':RnvimrToggle<CR>', { noremap = true })
map('n', '-', ':Explore<CR>', { noremap = true })
-- map('n', '<LEADER>.', ':RnvimrToggle<CR>', { noremap = true })
-- map('n', '<LEADER>', ':<C-U>LeaderGuide ' '<CR>', {noremap = true})

-- using space macs bindings instead

----splits
--map('n', '<LEADER>wv', ':vsplit<CR>', { noremap = true })
--map('n', '<LEADER>ws', ':split<CR>', { noremap = true })
--map('n', '<LEADER>wh', '<C-w>h', { noremap = true })
--map('n', '<LEADER>wj', '<C-w>j', { noremap = true })
--map('n', '<LEADER>wk', '<C-w>k', { noremap = true })
--map('n', '<LEADER>wl', '<C-w>l', { noremap = true })
--map('n', '<LEADER>wd', ':q<CR>', { noremap = true })
--map('n', '<C-h>', '<C-w>h', { noremap = true })
--map('n', '<C-j>', '<C-w>j', { noremap = true })
--map('n', '<C-k>', '<C-w>k', { noremap = true })
--map('n', '<C-l>', '<C-w>l', { noremap = true })

---- general
--map('n', '<LEADER>wq', ':wq<CR>', { noremap = true })
--map('n', '<LEADER>fs', ':w<CR>', { noremap = true })
--map('n', '<LEADER>a', ':', { noremap = true })
--map('n', '<LEADER>yy', '"+yy', { noremap = true })
--map('n', '<LEADER>pp', '"+p', { noremap = true })
---- technically set later on but this is more direct
---- saves one blink of ourside boarder

---- coding
--map('n', '<LEADER>fc', ':luafile %<CR>', { noremap = true })
--map('v', '<LEADER>fj', ':ToggleTermSendVisualSelection<CR>', { noremap = true })
--map('n', '<LEADER>fj', ':ToggleTermSendCurrentLine<CR>', { noremap = true })

---- tabs
--map('n', '<LEADER>tn', ':tabf %<CR>', { noremap = true })
--map('n', '<LEADER>tk', ':tabn<CR>', { noremap = true })
--map('n', '<LEADER>tj', ':tabp<CR>', { noremap = true })
--map('n', '<LEADER>td', ':tabc<CR>', { noremap = true })

---- terminal
--map('n', '<LEADER>ts', ':ToggleTerm direction=horizontal<CR>', { noremap = true })
--map('n', '<LEADER>tv', ':ToggleTerm direction=vertical size=81<CR>', { noremap = true })
--map('n', '<LEADER>tf', ':ToggleTerm direction=float<CR>', { noremap = true })
--map('n', '<LEADER>tt', ':ToggleTerm<CR>', { noremap = true })

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


-- require("indent_blankline").setup {
--     -- for example, context is off by default, use this to turn it on
--     -- show_current_context = true,
--     show_current_context_start = true,
-- }



-- rnvimr
g.rnvimr_enable_ex = 1
g.rnvimr_enable_picker = 1

-- vim slime
g.slime_target = "tmux"

-----------------
-- Tree Sitter --
-----------------

-- require 'nvim-treesitter.configs'.setup {
--     ensure_installed = { "c", "lua", "rust", "go" },
--     sync_install = false,
--     auto_install = true,
--     ignore_install = { "javascript" },
--     highlight = {
--         enable = true,

--         -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
--         -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
--         -- the name of the parser)
--         -- list of language that will be disabled
--         disable = {},
--     },
--     indent = {
--         enable = false,
--         disable = {},
--     };
--     rainbow = {
--         enable = true,
--         extended_mode = true,
--         max_file_lines = nil,
--     }
-- }

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
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

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
    vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)

    -- change highlight color of lenses in haskell
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
-- using nvim package instead
-- require('lspconfig')['hls'].setup {
--     on_attach = on_attach,
--     flags = lsp_flags,
-- }
require('lspconfig')['rust_analyzer'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
    -- Server-specific settings...
    -- settings = {
    --     ["rust-analyzer"] = {}
    -- }
}
require('lspconfig')['java_language_server'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['erlangls'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['elixirls'].setup {
    cmd = { "/etc/profiles/per-user/trevor/bin/elixir-ls" },
    on_attach = on_attach,
    flags = lsp_flags,
}


----------------
-- Completion --
----------------


local cmp = require("cmp")

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
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
        -- { name = 'vsnip' }, -- For vsnip users.
        { name = 'luasnip' }, -- For luasnip users.
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
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['rnix'].setup {
--     capabilities = capabilities
-- }
-- require('lspconfig')['rust-analyzer'].setup {
--     capabilities = capabilities
-- }
--

-----------
-- Idris --
-----------

-- when entering server add these key binds
local function idris2_on_attach(client)
    vim.keymap.set('n', '<leader>ia', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', '<leader>it', vim.lsp.buf.hover, bufopts)

    -- normal idris stuff
    vim.cmd [[nnoremap <Leader>ic <Cmd>lua require('idris2.code_action').case_split()<CR>]]
    vim.cmd [[nnoremap <Leader>im <Cmd>lua require('idris2.code_action').make_case()<CR>]]
    vim.cmd [[nnoremap <Leader>iw <Cmd>lua require('idris2.code_action').make_with()<CR>]]
    vim.cmd [[nnoremap <Leader>il <Cmd>lua require('idris2.code_action').make_lemma()<CR>]]
    vim.cmd [[nnoremap <Leader>id <Cmd>lua require('idris2.code_action').add_clause()<CR>]]
    vim.cmd [[nnoremap <Leader>io <Cmd>lua require('idris2.code_action').expr_search()<CR>]]
    vim.cmd [[nnoremap <Leader>ig <Cmd>lua require('idris2.code_action').generate_def()<CR>]]
    vim.cmd [[nnoremap <Leader>if <Cmd>lua require('idris2.code_action').refine_hole()<CR>]]
    vim.cmd [[nnoremap <Leader>ie <Cmd>lua require('idris2.code_action').expr_search_hints()<CR>]]
    vim.cmd [[nnoremap <Leader>ii <Cmd>lua require('idris2.code_action').intro()<CR>]]

    --
    vim.cmd [[nnoremap <Leader>ii <Cmd>lua require('idris2').intro()<CR>]]

end

local function save_hook(action)
    vim.cmd('silent write')
end

-- on attach is default
require('idris2').setup({
    server = { on_attach = idris2_on_attach },
    code_action_post_hook = save_hook
})

--------------
-- Haskell  --
--------------

local ht = require('haskell-tools')
local def_opts = { noremap = true, silent = true, }
ht.setup {
    -- tools = {
    --     hoogle = {
    --         mode = 'telescope-local'
    --     };
    -- };
    hls = { on_attach = function(client, bufnr)
        local opts = vim.tbl_extend('keep', def_opts, { buffer = bufnr, })
        -- haskell-language-server relies heavily on codeLenses,
        -- so auto-refresh (see advanced configuration) is enabled by default
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', '<leader>k', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, bufopts)


        -- haskell functions
        vim.keymap.set('n', '<space>hl', vim.lsp.codelens.run, opts)
        vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)

        vim.api.nvim_set_hl(0, 'LspCodeLens', { fg = '#5e5086', underline = false, })
        -- default_on_attach(client, bufnr)  -- if defined, see nvim-lspconfig
    end,
    },
}
-- Suggested keymaps that do not depend on haskell-language-server
-- Toggle a GHCi repl for the current package
vim.keymap.set('n', '<leader>rr', ht.repl.toggle, def_opts)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set('n', '<leader>rf', function()
    ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, def_opts)
vim.keymap.set('n', '<leader>rq', ht.repl.quit, def_opts)


local async = require "plenary.async"
-- require('haskell-tools').hoogle.hoogle_signature()
-- require('telescope').load_extension('ht')
-- require('telescope').setup {}
