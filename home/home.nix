# imports
# { config, pkgs, lib, idris2-pkgs, ... }:
# { config, pkgs, lib, pkgs-unstable, ... }:
{ config, pkgs, lib, fetchFromGithub, ... }:

# here is where everything starts, if you wanna define something
# you will need to do a let, in block above this to import.
# This is a functional programming thing so that's why it seems weird.
let
  foreground = "#e9e0cb";
  background = "#161219";
  color1 = "B7A365";
  color2 = "#85718B";
  # my-kanata = pkgs.kanata.overrideAttrs (old: rec {
  #   pname = "kanata";
  #   version = "1.6.1";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "jtroo";
  #     repo = pname;
  #     # rev = "v${version}";
  #     rev = "bb925fb38e20466ccf2f2bcb259b29b1ecad990c";
  #     sha256 = "sha256-BZ2aMZzCiNQSovFF1JPX7/EekvIjy0MhTBUthyZ24Ro=";
  #   };

  #   cargoDeps = old.cargoDeps.overrideAttrs (lib.const {
  #     # name = "${pname}-$v{version}";
  #     # name = "kanata-1.6.1";
  #     inherit src;
  #     # outputHash = "sha256-oJVGZhKJVK8q5lgK+G+KhVupOF05u37B7Nmv4rrI28I=";
  #     outputHash = "sha256-iSoqg9rWw259u7b0ndPq8P6uG4R7tArVLDO9EyZjgAg=";

  #     });
    # });
in
{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;
  # nixpkgs.unstable.config.allowUnfree = true;

  # Defining home packages
  # Put non customixed packages here
  # organize these!
  home.packages = [
     pkgs.pcsx2
     # pkgs.gcc
     pkgs.plover.dev
     # nixpkgs-unstable/.uiua
     pkgs.unstable.uiua
     # pkgs.orca-slicer
     # pkgs.kicad-small
     pkgs.plover.dev
     pkgs.qutebrowser
    # my-kanata
    # pkgs.kanata-with-cmd
    # pkgs-unstable.plasticity
    # pkgs.gnuplot
    pkgs.racket_7_9
    pkgs.fleng
    pkgs.scryer-prolog
    # pkgs.swiProlog
    pkgs.cmake
    pkgs.openal
    pkgs.guile
    pkgs.chez
    pkgs.lean4
    # haskell version is not broken
    #pkgs.shen-sbcl
    pkgs.rpcs3
    #pkgs.haskellPackages.shentongs
    pkgs.chickenPackages_5.chickenEggs.shen
    # pkgs.unstable.osu-lazer-bin
    # pkgs.osu-lazer
    pkgs.gnumake
    pkgs.solvespace
    # pkgs.freecad
    pkgs.pavucontrol
    # pkgs.krita
    # pkgs.pcsx2
    # pkgs.ao
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
    # pkgs.w3m # text web browser
    # pkgs.virt-manager
    pkgs.gopher # alternative to html
    pkgs.unzip
    pkgs.htop
    pkgs.cura
    pkgs.julia-bin
    pkgs.openscad
    pkgs.qmk
    pkgs.qmk-udev-rules
    pkgs.gnumake
    pkgs.ranger
    pkgs.xmobar
    pkgs.xdotool
    pkgs.glxinfo
    #pkgs.wine-staging
    #pkgs.wine64
    # pkgs.dolphin-emu
    # pkgs.github-desktop
    pkgs.screen
    pkgs.gd
    pkgs.usbutils
    pkgs.go
    pkgs.gopls
    pkgs.arduino
    pkgs.arduino-cli
    pkgs.tinygo
    # I commented this out not sure why
    # pkgs.rustup
    pkgs.rustc
    pkgs.rustfmt
    pkgs.cargo
    pkgs.nnn
    pkgs.helix
    pkgs.elvish
    pkgs.inetutils
    # pkgs.influxdb
    pkgs.mpv
    pkgs.ytfzf
    # pkgs.interception-tools

    pkgs.opentabletdriver
    pkgs.assimp

    # pkgs.blender
    pkgs.arandr
    pkgs.appimage-run

    # apl
    pkgs.gnuapl
    pkgs.cbqn

    pkgs.lfe



    # lisp
    pkgs.sbcl
    pkgs.libGL
    pkgs.libGLU
    pkgs.libGL.dev
    pkgs.libGL.out
    pkgs.SDL
    pkgs.SDL2.dev
    pkgs.SDL2.out
    pkgs.sbclPackages.sdl2
    pkgs.snd
    pkgs.libsndfile
    # pkgs.pkg-config
    # doing this bad way non nix
    # pkgs.lispPackages.quicklisp
    pkgs.ani-cli
    pkgs.gnuapl
    pkgs.maxima
    pkgs.gforth
    pkgs.supercollider
    pkgs.qjackctl

    pkgs.p7zip

    # pkgs.idris2-pkgs.idris2
    # pkgs.idris2-pkgs.lsp
    # pkgs.idris2-pkgs.idris2-python
    # pkgs.idris2-pkgs.idris2
    # idris2-pkgs.idris2

    # pkgs.texlive.combined.scheme-medium
    pkgs.texlive.combined.scheme-full
    pkgs.latexrun

    pkgs.glow
    pkgs.zoxide
    # pkgs.exa

    # aduino stuff
    pkgs.pkgsCross.avr.buildPackages.gcc
    # pkgs.pkg-config
    pkgs.avrdude
    pkgs.libudev-zero

    #linters
    # pkgs.cargo
    pkgs.clang

    # pkgs.rnix-lsp
    # pkgs.pyright

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
    # this doesn't work if you don't move a mouse
    # so a virtual event from python.mouse won't reshow cursor
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
    # zsh = {
    #     enable = true;
    # };

    emacs = {
      enable = true;
      extraPackages = epkgs: [
        epkgs.vterm
        epkgs.julia-vterm
        # epkgs.lsp-pyright
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
        # hackish way to not fully reconfigure sbcl for more space
        sbcl = "sbcl --dynamic-space-size 2Gb";
        ls = "ls --color";
        vihome = "vi ~/.config/nixpkgs/home.nix";
        vinix = "suod vi /etc/nixos/configuration.nix";
        nup = "sudo nixos-rebuild switch --impure --flake ~/github/dotfiles/";
      };
      enableAutosuggestions = true;
      enableCompletion = false;
      syntaxHighlighting.enable = true;
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
