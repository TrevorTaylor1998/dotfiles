# imports
{ config, pkgs, lib, idris2-pkgs, ... }:

# here is where everything starts, if you wanna define something
# you will need to do a let, in block above this to import.
# This is a functional programming thing so that's why it seems weird.
let
  foreground = "#e9e0cb";
  background = "#161219";
  color1 = "B7A365";
  color2 = "#85718B";
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;



  # Defining home packages
  # Put non customixed packages here
  # organize these!
  home.packages = [
    # pkgs.gcc
    pkgs.gnuplot
    pkgs.cmake
    pkgs.gnumake
    pkgs.solvespace
    pkgs.pywal
    pkgs.ripgrep
    pkgs.fd
    pkgs.coreutils
    # pkgs.st
    pkgs.glibc
    pkgs.lukesmithxyz-st
    pkgs.wget
    pkgs.nix-prefetch-github
    pkgs.neofetch # bloat (haha)
    pkgs.acpi
    pkgs.w3m # text web browser
    pkgs.virt-manager
    pkgs.gopher # alternative to html
    pkgs.unzip
    pkgs.htop
    pkgs.cura
    pkgs.julia-lts
    pkgs.openscad
    pkgs.qmk
    pkgs.qmk-udev-rules
    pkgs.gnumake
    pkgs.ranger
    pkgs.xmobar
    pkgs.xdotool
    pkgs.glxinfo
    pkgs.wine-staging
    pkgs.dolphin-emu
    # pkgs.github-desktop
    pkgs.screen
    pkgs.gd
    pkgs.usbutils
    pkgs.go
    pkgs.gopls
    pkgs.arduino
    pkgs.arduino-cli
    pkgs.tinygo
    # pkgs.rustup
    pkgs.nnn
    pkgs.helix
    pkgs.elvish
    pkgs.inetutils
    pkgs.influxdb
    pkgs.mpv
    pkgs.ytfzf
    pkgs.sbcl
    pkgs.ani-cli

    pkgs.idris2-pkgs.idris2
    pkgs.idris2-pkgs.lsp
    pkgs.idris2-pkgs.idris2-python
    # pkgs.idris2-pkgs.idris2
    # idris2-pkgs.idris2

    # pkgs.texlive.combined.scheme-medium
    pkgs.texlive.combined.scheme-full
    pkgs.latexrun

    pkgs.glow
    pkgs.zoxide
    pkgs.exa

    # aduino stuff
    pkgs.pkgsCross.avr.buildPackages.gcc
    # pkgs.pkg-config
    pkgs.avrdude
    pkgs.libudev-zero

    #linters
    # pkgs.cargo
    pkgs.clang

    pkgs.rnix-lsp
    pkgs.pyright

    # PLAN 9 (aka cirno)
    pkgs.plan9port
  ];

  # home files for packages that don't have modules
  home.file."./.config/helix/config.toml".source = ./config.toml;
  home.file."./.config/elvish/rc.elv".source = ./rc.elv;
  home.file."./.config/spnavrc".source = ./spnavrc;
  home.file.".XCompose".source = ./xcompose;
  home.file."./.w3m/config".source = ./w3mrc;

  imports = [
    ./nvim/nvim.nix
  ];

  # services are background programs like hiding the mouse or making the
  # screen redder as night time approches.
  services = {
    picom = {
      enable = true;
      backend = "glx";
      # this makes an aplication slightly transparent so you
      # can still see your background
      opacityRules =
        [ "85: class_g = 'Solvespace'" ];
      vSync = true;
    };


    # This hides the mouse if you don't use it for a second
    # It is here because the mouse cursor annoys me
    unclutter = {
      enable = true;
      timeout = 1;
    };

    flameshot = {
      enable = true;
    };

  };


  # This is where the programs will be defined
  # Programs with few options are defined here
  # Otherwise they will also have a config file
  # in the same directory
  programs = {

    emacs = {
      enable = true;
      extraPackages = epkgs: [
        epkgs.vterm
        epkgs.julia-vterm
        epkgs.lsp-pyright
        epkgs.lsp-latex
        epkgs.lsp-julia
        epkgs.lsp-haskell
      ];
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    # vim like text editor
    kakoune = {
      enable = true;
      extraConfig = builtins.readFile ./kak/kakrc;
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

    zathura = {
      enable = true;
      options = {
        recolor = true;
        completion-bg = background;
        completion-fg = foreground;
        completion-group-bg = background;
        completion-group-fg = color2;
        completion-highlight-bg = foreground;
        completion-highlight-fg = background;

        recolor-lightcolor = background;
        recolor-darkcolor = foreground;
        default-bg = background;
        inputbar-bg = background;
        inputbar-fg = foreground;

        notification-bg = background;
        notification-fg = foreground;
        notification-error-bg = color1;
        notification-error-fg = foreground;
        notification-warning-bg = color1;
        notification-warning-fg = foreground;
        statusbar-bg = background;
        statusbar-fg = foreground;
        index-bg = background;
        index-fg = foreground;
        index-active-bg = foreground;
        index-active-fg = background;
        render-loading-bg = background;
        render-loading-fg = foreground;
      };
    };

    firefox = {
      enable = true;
    };

    # This is an alternate bash type thing. Basically what you
    # type into terminal
    # the built in settings make the config file very short
    zsh = {
      enable = true;
      shellAliases = {
        ls = "ls --color";
        vihome = "vi ~/.config/nixpkgs/home.nix";
        vinix = "suod vi /etc/nixos/configuration.nix";
        nup = "sudo nixos-rebuild switch --impure --flake ~/github/dotfiles/";
      };
      enableAutosuggestions = true;
      enableCompletion = false;
      enableSyntaxHighlighting = true;
      autocd = true;
      initExtraBeforeCompInit = builtins.readFile ./zsh/zshrc;
    };

    # terminal multiplexer
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
      extraConfig = builtins.readFile ./tmux/tmux.conf;
    };

    # xmobar = {
    #   enable = true;
    #   # extraConfig = ./xmobarrc;
    # };


    # pressing super-p will bring up a application launcher with fuzzy finding.
    # using built in wmii instead
    rofi = {
      enable = true;
    };


    # this is configured in configuation.nix since I have to configure
    # the personal acess token. Could probably get this to work
    # currently is done in the normal (bad) way
    git = {
      enable = false;
      userName = "taylot6";
      userEmail = "taylot6@unlv.nevada.edu";
      extraConfig = {
        credential.helper = "${
          pkgs.git.override { withLibsecret = true; }
        }/bin/git/credential-libsecret";
      };
    };
  };


  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  # home.username = "nadleeh";
  # home.homeDirectory = "/home/nadleeh";

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
