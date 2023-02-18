{ config, pkgs, lib, ... }:

# treesitter being broken
# rainbow not working

# got from
# https://github.com/emptyflask/nix-home/blob/master/programs/neovim/default.nix#L21
let
  concatFiles = files:
    pkgs.lib.strings.concatMapStringsSep "\n" builtins.readFile files;

  # installs a vim plugin from git with a given tag / branch
  # usage: pluginGit "HEAD" "ellisonleao/gruvbox.nvim");
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
    };
  };
in

with pkgs;
{
  #nvim stuff
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;

    # not using nou
    # ${builtins.readFile ./plugins.lua}
    extraConfig = ''
      ${builtins.readFile ./init.vim}
      lua << EOF
        ${builtins.readFile ./init.lua}
      EOF
    '';

    plugins = with pkgs.vimPlugins; [
      vim-commentary
      vim-surround
      vim-gitgutter
      vim-nix
      hop-nvim
      # nvim-ts-rainbow
      toggleterm-nvim
      vim-slime
      rnvimr
      agda-vim
      idris2-vim
      vim-elixir
      tabular
      nvim-lspconfig
      lsp_signature-nvim
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline
      nvim-cmp
      vim-vsnip
      cmp-vsnip
      luasnip
      cmp_luasnip
      vimtex

      # (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
      nvim-treesitter.withAllGrammars
      # nvim-base16
      pywal-nvim
      wal-vim
      # vim-which-key
      which-key-nvim

      # This is how to install plugins if they do not have a nix version
      (pluginGit "master" "jimmay5469/vim-spacemacs")
      (pluginGit "master" "pseewald/vim-anyfold")
      # (pluginGit "master" "thalesmello/tabfold")
      (pluginGit "master" "arecarn/vim-fold-cycle")
      (pluginGit "master" "yuratomo/w3m.vim")

      # (pluginGit "master" "lukas-reineke/indent-blankline.nvim")
      # haven't gotten these to work ye)
      # (pluginGit "main" "MunifTanjim/nui.nvim")
      # (pluginGit "main" "ShinKage/idris2-nvim")
    ];

    extraPackages = [
      pkgs.rustc
      pkgs.rustfmt
      pkgs.cargo
      pkgs.clang
      pkgs.golint
      pkgs.gofumpt
      pkgs.rnix-lsp
      pkgs.vim-vint
      pkgs.erlang-ls
      pkgs.elixir_ls
      pkgs.java-language-server
      pkgs.rust-analyzer
      pkgs.kak-lsp
      # pkgs.haskell-language-server
      pkgs.python-language-server
      pkgs.sumneko-lua-language-server
      pkgs.gopls
      # pkgs.tree-sitter-grammars.tree-sitter-nix
      pkgs.nixfmt
      # pkgs.idris2-lsp
    ];

  };

}
