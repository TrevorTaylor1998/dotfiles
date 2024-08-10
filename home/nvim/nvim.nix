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
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPlugin {
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
      # new vim commands
      vim-commentary
      vim-surround
      hop-nvim
      # needs binding
      tabular

      # git stuff
      vim-gitgutter

      # utilities
      toggleterm-nvim
      vim-slime
      which-key-nvim


      # language plugins
      vim-nix
      agda-vim
      idris2-vim
      vim-elixir
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
      nvim-treesitter.withAllGrammars
      # not using ranger anymore too slow
      # rnvimr

      # haskell stuff
      haskell-vim
      haskell-tools-nvim
      plenary-nvim
      telescope-nvim
      # vim-hoogle
      # telescope_hoogle
      # intero-neovim

      # need to fix
      # nvim-ts-rainbow

      # colors
      pywal-nvim
      wal-vim

      # This is how to install plugins if they do not have a nix version
      # (pluginGit "master" "jimmay5469/vim-spacemacs")
      (pluginGit "master" "pseewald/vim-anyfold")
      # (pluginGit "master" "thalesmello/tabfold")
      (pluginGit "master" "arecarn/vim-fold-cycle")
      (pluginGit "master" "yuratomo/w3m.vim")
#      (pluginGit "master" "Joshiah-tan/plover-vim-tu")

      # now have an idea can use a flake from claymanager idris2 nix repo
      (pluginGit "main" "MunifTanjim/nui.nvim")
      (pluginGit "main" "ShinKage/idris2-nvim")
    ];

    extraPackages = [
      pkgs.rustc
      pkgs.rustfmt
      pkgs.cargo
      pkgs.clang
      pkgs.golint
      pkgs.gofumpt
      pkgs.vim-vint
      pkgs.gopls
      # pkgs.tree-sitter-grammars.tree-sitter-nix
      pkgs.nixfmt
      # pkgs.idris2-lsp

      # language servers
      # pkgs.rnix-lsp
      pkgs.kak-lsp
      pkgs.erlang-ls
      pkgs.elixir_ls
      pkgs.java-language-server
      pkgs.rust-analyzer
      pkgs.haskell-language-server
      # pkgs.python-language-server
      pkgs.sumneko-lua-language-server

      # languages 
      # these are here so we can still have language server find the correct 
      # language even if we don't have them available in userspace. So 
      # bascially vim has acess but we do not
      # then if we are in a shell these will be acessable because shell 
      # will overwrite these... hopefully
      pkgs.ghc
      # pkgs.python
      pkgs.go
      # pkgs.idris2
    ];

  };

}
