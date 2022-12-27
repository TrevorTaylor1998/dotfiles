{ config, pkgs, lib, vimUtils, ... }:

# This is to set the xresources colors. Eventaually should make dyanamic and
# read proper file
let
  foreground = "#e9e0cb";
  background = "#161219";
  color1 = "#B7A365";
  color2 = "#85718B";
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  # Defining home packages
  # Put non customixed packages here
  home.packages = [
    pkgs.emacs
    pkgs.solvespace
    pkgs.pywal
    pkgs.lukesmithxyz-st
    pkgs.wget
    pkgs.nix-prefetch-github
    pkgs.neofetch # bloat (haha)
    pkgs.acpi
    pkgs.w3m # text web browser
    pkgs.gopher # alternative to html
    pkgs.unzip
    pkgs.htop
    pkgs.cura
    pkgs.atom
    pkgs.julia_16-bin
    # pkgs.openscad
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
    pkgs.elvish
    pkgs.green-pdfviewer
    # pkgs.libsixel
    pkgs.vbam
    pkgs.mpv

    # Latex
    pkgs.texlive.combined.scheme-medium
    pkgs.latexrun

    # pkgs.polymc
    pkgs.plan9port

    pkgs.ant
    pkgs.jdk

    # erlang/elixir stuff
    pkgs.erlang
    pkgs.elixir
    # pkgs.erlfmt
    pkgs.rebar3

    # agda
    pkgs.agda

    pkgs.glow
    pkgs.zoxide
    pkgs.exa

    pkgs.ytfzf
    pkgs.ani-cli
  ];

  # This is where some home files will go
  home.file."./.config/helix/config.toml".source = ./config.toml;
  home.file."./.config/elvish/rc.elv".source = ./rc.elv;
  home.file."./.config/spnavrc".source = ./spnavrc;
  home.file."./.w3m/config".source = ./w3mrc;

  imports = [
    ./nvim.nix
  ];

  # This autoloads with unstable
  services = {
    picom = {
      enable = true;
      # opacityRule = ["85: class_g = 'st-256color'" "85: class_g = 'Solvespace'" "80: class_g = 'xterm'"];
      opacityRules =
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


