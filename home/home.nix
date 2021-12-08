{ config, pkgs, lib, vimUtils, ... }:

# let packages in unstable be installed
let
  pkgsUnstable = import <nixpkgs-unstable> {};
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

 # Defining home packages
 # Put non customixed packages here
  home.packages = [
    pkgs.solvespace
    pkgs.pywal
    pkgs.st                   # customize (nevermind suckless is weird)
    pkgs.dmenu                # customize (nevermind suckless is weird)
    pkgs.wget
    pkgs.git                  # Probably can put user info here
    pkgs.nix-prefetch-github
    pkgs.neofetch             # bloat (haha)
    pkgs.acpi
    pkgs.zathura              # customize
    pkgs.w3m
    pkgs.gcc
    pkgs.virt-manager

    # Tree Sitter Stuff
    pkgsUnstable.tree-sitter-grammars.tree-sitter-nix

    # Language Servers
    pkgs.rnix-lsp
    pkgs.kak-lsp
    pkgs.haskell-language-server
    pkgs.python-language-server
    pkgs.ccls
  ];


  # The rest of the config chages files using overlays
  # This means that every config file is described in one place
  # and .config will be either empty or it will have files that point
  # to something in the nix-store

  # See this github for overlay options
  # https://github.com/nix-community/home-manager/tree/master/modules/programs

  # import overlay for neovim nightly
  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];


  # This is settings for window manager xmonad
  xsession = {
    enable = true;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      # extraPackages = with pkgs.haskellPackages; [
      #   xmonad-contrib
      #   xmoand-extras
      #   xmonad
      # ];
      config = ./xmonad.hs;
    };
  };


  # This is where services are like compostors or redshift and the like
  # I don't have these auto load but might add that
  services = {
    # still need config file for opacity rules
    picom = {
      enable = true;
      opacityRule = ["85: class_g = 'st-256color'"];
      backend = "glx";
      extraOptions = ''
      opacity-rule = ["85:class_g = 'st-256color'"];
      '';
      vSync = true;
    };


    # still need to run
    # systemctl --user start unclutter.service
    # don't need to run anymore
    unclutter = {
      enable = true;
      timeout = 1;
    };


    # polybar = {
    #   enable = true;
    #   script = " polybar bar &";
    #   config = ./config.ini;
    # };

  };


  # This is where the programs will be defined
  # Programs with few options are defined here
  # Otherwise they will also have a config file
  # in the same directory
  programs = {

    # vim like text editor
    kakoune = {
        enable = true;
        extraConfig = builtins.readFile ./kakrc;
        config = {
          showMatching = true;
        };
        plugins = with pkgs.kakounePlugins; [
          prelude-kak
          connect-kak
          quickscope-kak
          kakoune-easymotion
          kakoune-rainbow
          kakoune-buffers
          tabs-kak
        ];
    };


    #nvim stuff
    neovim = {
      enable = true;
      package = pkgs.neovim-nightly;
      extraConfig = builtins.readFile ./init.vim;
      plugins = with pkgs.vimPlugins; [
        vim-vinegar
        vim-commentary
        vim-surround
        vim-easymotion
        vim-gitgutter
        #vim-polygot
        vim-tmux-navigator
        julia-vim
        rainbow
        vim-nix
        vim-slime
        YouCompleteMe
        nvim-treesitter
        nvim-lspconfig
        nvim-compe
      ];
      viAlias  = true;
      vimAlias = true;
    };


    qutebrowser = {
      enable = true;
      extraConfig =
        ''
        config.bind('t', 'set-cmd-text --space :open -t')
        config.bind('E', 'tab-next')
        config.bind('N', 'tab-prev')
        config.bind('M', 'back')
        config.bind('I', 'forward')
        config.bind('<Ctrl+n>', 'scroll-px 0 200')
        config.bind('<Ctrl+p>', 'scroll-px 0 -200')
        c.hints.chars = "arstneio"
        '';
    };


    firefox = {
      enable = true;
    };


    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = true;
      # syntaxHighlighting.enable = true;
      autocd = true;
      initExtraBeforeCompInit = builtins.readFile ./zshrc;

    };


    tmux = {
      enable = true;
      baseIndex = 1;
      clock24 = true;
      shortcut = "a";
      keyMode = "vi";
      plugins = with pkgs.tmuxPlugins; [
        fingers
        {
          plugin = power-theme;
          extraConfig = "set -g @tmux_power_theme 'default'";
        }
        {
          plugin = continuum;
          extraConfig = ''
            set -g @continuum-restore 'on'
            set -g @continuum-save-interval '15' # minutes
          '';
        }

      ];
      extraConfig = builtins.readFile ./tmux.conf;
    };
  };


  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "trevor";
  home.homeDirectory = "/home/trevor";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.05";
}
