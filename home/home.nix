{ config, pkgs, lib, vimUtils, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Defining home packages
  # Put non customixed packages here
  home.packages = [
    pkgs.solvespace
    pkgs.pywal
    # pkgs.st
    pkgs.lukesmithxyz-st
    pkgs.wget
    pkgs.nix-prefetch-github
    pkgs.neofetch # bloat (haha)
    pkgs.acpi
    pkgs.zathura # customize
    pkgs.w3m # text web browser
    pkgs.gopher # alternative to html
    pkgs.unzip
    pkgs.htop
    # pkgs.ppsspp
    pkgs.cura
    # pkgs.prusa-slicer
    pkgs.atom
    pkgs.julia_16-bin
    pkgs.openscad
    pkgs.sage
    # pkgs.qmk
    # pkgs.qmk-udev-rules
    pkgs.gnumake
    pkgs.ranger
    pkgs.xmobar
    pkgs.xdotool
    pkgs.wine-staging
    pkgs.gnuplot
    pkgs.blender
    pkgs.go_1_18
    pkgs.arduino
    pkgs.arduino-cli
    pkgs.tinygo
    pkgs.freecad
    pkgs.nnn
    # pkgs.helix
    pkgs.elvish
    # sixel stuff
    # need to do xterm -ti vt340 or add xrources and do xrdb -set thing
    pkgs.green-pdfviewer
    pkgs.libsixel
    # pkgs.netsurf.browser.override {ui="test";}
    # 'programs.netsurf.browser = pkgs.netsurf.browser.override { ui = "test"; };'
    pkgs.vbam

    # pkgs.polymc
    pkgs.plan9port

    # this is stuff for linters and checkers
    # these are required files
    # pkgs.python39Packages.flake8

    # java stuff
    pkgs.ant
    pkgs.jdk

    # erlang/elixir stuff
    pkgs.erlang
    # pkgs.erlfmt
    pkgs.erlang-ls
    pkgs.elixir

    # agda
    pkgs.agda

    #linters
    # pkgs.clangd
    # pkgs.rustup
    pkgs.rustc
    pkgs.rustfmt
    pkgs.cargo
    pkgs.clang
    pkgs.golint
    pkgs.gofumpt
    pkgs.rnix-lsp
    pkgs.vim-vint

    pkgs.glow
    pkgs.zoxide
    pkgs.exa
    pkgs.nixfmt

    # Tree Sitter Stuff
    pkgs.tree-sitter-grammars.tree-sitter-nix
    # pkgs.tree-sitter-grammars.tree-sitter-lua

    # Language Servers
    pkgs.java-language-server
    pkgs.rust-analyzer
    pkgs.kak-lsp
    # pkgs.haskell-language-server
    pkgs.python-language-server
    pkgs.sumneko-lua-language-server
    pkgs.gopls
    # pkgs.ccls

    # pkgs.osu-lazer
  ];

  # This is where some home files will go
  home.file."./.config/helix/config.toml".source = ./config.toml;
  home.file."./.config/elvish/rc.elv".source = ./rc.elv;
  home.file."./.config/spnavrc".source = ./spnavrc;
  # home.file."./.Xresouces".source = ./xresources;

  # services.xserver.displayj-
  # xresources =
  #   {
  #     properties = {
  #       "xterm.decTerminalID" = "vt340";
  #     };
  #   };

  # The rest of the config chages files using overlays
  # This means that every config file is described in one place
  # and .config will be either empty or it will have files that point
  # to something in the nix-store

  # See this github for overlay options
  # https://github.com/nix-community/home-manager/tree/master/modules/programs

  # This is settings for window manager xmonad
  # xsession = {
  #   enable = true;
  #   windowManager.xmonad = {
  #     enable = true;
  #     enableContribAndExtras = true;
  #     extraPackages = haskellPackages:
  #       [
  #         haskellPackages.xmobar
  #         #   xmonad-contrib
  #         #   xmoand-extras
  #         #   xmonad
  #       ];
  #     config = ./xmonad.hs;
  #   };
  # };

  # This autoloads with unstable
  services = {
    picom = {
      enable = true;
      # opacityRule = ["85: class_g = 'st-256color'" "85: class_g = 'Solvespace'" "80: class_g = 'xterm'"];
      opacityRule =
        [ "85: class_g = 'st-256color'" "85: class_g = 'Solvespace'" ];
      backend = "glx";
      # extraOptions = ''
      # opacity-rule = ["85:class_g = 'st-256color'"];
      # '';
      vSync = true;
    };

    unclutter = {
      enable = true;
      timeout = 1;
    };

  };

  # This is where the programs will be defined
  # Programs with few options are defined here
  # Otherwise they will also have a config file
  # in the same directory
  programs = {

    lf = {
      enable = true;
      settings = { hidden = true; };
    };

    #nvim stuff
    neovim = {
      enable = true;
      # extraConfig = builtins.readFile ./init.vim;
      # coc.enable = true;
      # withNodejs = true;
      extraConfig = ''
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
        nvim-ts-rainbow
        toggleterm-nvim
        vim-slime
        # hologram-nvim
        # rust-tools-nvim
        rnvimr
        agda-vim

        nvim-lspconfig
        lsp_signature-nvim

        # completion 
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        nvim-cmp
        vim-vsnip
        cmp-vsnip


        (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
        nvim-base16
        pywal-nvim
      ];
      viAlias = true;
      vimAlias = true;
    };


    qutebrowser = {
      enable = true;
      extraConfig = ''
        config.bind('t', 'set-cmd-text --space :open -t')
        config.bind('E', 'tab-next')
        config.bind('N', 'tab-prev')
        config.bind('M', 'back')
        config.bind('I', 'forward')
        config.bind('<Ctrl+n>', 'scroll-px 0 200')
        config.bind('<Ctrl+p>', 'scroll-px 0 -200')
        c.hints.chars = "arstneio"
        c.content.blocking.method = 'adblock'
        c.content.blocking.adblock.lists = ['https://easylist.to/easylist/easylist.txt', 'https://easylist.to/easylist/easyprivacy.txt', 'https://easylist-downloads.adblockplus.org/easylistdutch.txt', 'https://easylist-downloads.adblockplus.org/abp-filters-anti-cv.txt', 'https://www.i-dont-care-about-cookies.eu/abp/', 'https://secure.fanboy.co.nz/fanboy-cookiemonster.txt']
      '';
    };

    firefox = { enable = true; };

    zsh = {
      enable = true;
      enableAutosuggestions = true;
      enableCompletion = false;
      # syntaxHighlighting.enable = true;
      shellAliases = {
        xterm = "xterm -ti vt340";
        ls = "ls --color";
      };
      autocd = true;
      initExtraBeforeCompInit = builtins.readFile ./zshrc;

    };

    # elvish = { enable = true; };

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

    # xmobar = {
    #   enable = true;
    #   # extraConfig = ./xmobarrc;
    # };

    rofi = { enable = true; };

    git = {
      enable = false;
      userName = "taylot6";
      userEmail = "taylot6@unlv.nevada.edu";
      extraConfig = {
        credential.helper = "${
pkgs.git.override { withLibsecret = true;
}
}/bin/git/credential-libsecret";
      };
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
  home.stateVersion = "21.11";
}

