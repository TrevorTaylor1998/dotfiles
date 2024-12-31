{ config, pkgs, lib, fetchFromGithub, inputs, ... }:

# here is where everything starts, if you wanna define something
# you will need to do a let, in block above this to import.
# This is a functional programming thing so that's why it seems weird.
let
  foreground = "#e9e0cb";
  background = "#161219";
  color1 = "B7A365";
  color2 = "#85718B";
in {
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  
  imports = [
    inputs.textfox.homeManagerModules.default
    # inputs.hyprland.homeManagerModules.default  
  ];

  # Defining home packages
  # Put non customixed packages here
  # organize these!
  home.packages = [
    # pkgs.raylib
    pkgs.libGL
    pkgs.dyalog
    pkgs.xorg.libX11
    pkgs.xorg.libX11.dev
    pkgs.glfw
    pkgs.j
    h
    pkgs.discord
    pkgs.devilutionx
    pkgs.hyprshade
    pkgs.hyprlandPlugins.hypr-dynamic-cursors
    pkgs.hyprlandPlugins.hy3
    pkgs.nixfmt-classic
    pkgs.zathura
    #pkgs.hyprland
    pkgs.hyprpaper
    #pkgs.waybar
    #pkgs.tofi
    #pkgs.kitty
    #pkgs.firefox
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
    #pkgs.racket_7_9
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
    # python libcurses thing broken
    # pkgs.cura
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
    # pkgs.tinygo
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


  wayland.windowManager.hyprland = {
    enable = true;
    package = pkgs.hyprland;
    # this is for flake but I cannot get it to work
    # plugins = [ inputs.hy3.packages."${pkgs.system}".default ];
    plugins = [
      pkgs.hyprlandPlugins.hy3
      pkgs.hyprlandPlugins.hypr-dynamic-cursors
      pkgs.hyprlandPlugins.borders-plus-plus
      # inputs.hyprchroma.packages.${pkgs.system}.Hypr-DarkWindow
    ];
    
    settings = {
      "plugin:dynamic-cursors" = {
        mode = "tilt";
      };
      "plugin:borders-plus-plus" = {
        "add_borders" = 0;
        # "col.border_2" = "col.border_1";
      };
      # "chromakey_background" = "7,8,17";
      
      "$mod" = "SUPER";
      "$terminal" = "kitty";
      "$menu" = "tofi-run | xargs hyprctl dispatch exec --";

      exec-once = [ "hyprpaper"
                    "waybar &"
                    "kitty" ];

      general = {
        "gaps_in" = 5;
        "gaps_out" = 8;
        "layout" = "hy3";
        "border_size" = 2;
      };

      layerrule = [
        "blur, tofi"
        "blur, waybar"
      ];

      monitor = ",preferred,auto,auto";
      decoration = {
        rounding = 0;
        active_opacity = "0.92";
        inactive_opacity = "0.92";
        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };

        blur = {
          enabled = true;
          xray = true;
          size = 8;
          passes = 3;
          noise = 0.3;
          vibrancy = 0.1696;
          popups = true;
          "ignore_opacity" = true;
          "new_optimizations" = true;
        };
      };

      animations = {
        enabled = "yes, please :)";

        # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade" # @
        ];
      };

      # keybindings
      bind = [
        "$mod, return, exec, $terminal"
        "$mod, c, killactive,"
        "$mod, m, exit,"
        "$mod, b, exec, killall -SIGUSR2 waybar"
        "$mod, v, togglefloating,"
        #"$mod, E,"
        "$mod, r, exec, hyprctl reload"
        "$mod, q, exec, $menu"
        #"$mod, p, pseudo,"
        "$mod, w, togglesplit,"
        "$mod, h, hy3:movefocus, l"
        "$mod, l, hy3:movefocus, r"
        "$mod, k, hy3:movefocus, u"
        "$mod, j, hy3:movefocus, d"
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"
        "$mod, f, fullscreen, 1"
        "$mod, d, hy3:makegroup, h"
        "$mod, s, hy3:makegroup, v"
        "$mod, z, hy3:makegroup, tab"
        "$mod, a, hy3:changefocus, raise"
        "$mod shift, a, hy3:changefocus, lower"                    
        
        "$mod shift, f, fullscreen, 0"
        "$mod shift, h, hy3:movewindow, l, once"
        "$mod shift, l, hy3:movewindow, r, once"          
        "$mod shift, k, hy3:movewindow, u, once"
        "$mod shift, j, hy3:movewindow, d, once"
        # adding right hand workplace switching
        "$mod, u, workspace, 1"
        "$mod, i, workspace, 2"
        "$mod, o, workspace, 3"
        "$mod, p, workspace, 4"
        "$mod, bracketleft, workspace, 5"
        "$mod shift, u, movetoworkspace, 1"
        "$mod shift, i, movetoworkspace, 2"
        "$mod shift, o, movetoworkspace, 3"
        "$mod shift, p, movetoworkspace, 4"
        "$mod shift, bracketleft, movetoworkspace, 5"

      ] ++ (builtins.concatLists (builtins.genList (i:
        let ws = i + 1;
        in [
          "$mod, code:1${toString i}, workspace, ${toString ws}"
          "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
        ]) 9));

      # mouse
      bindm = [ "$mod, mouse:272, movewindow" "$mod, mouse:273, resizewindow" ];

      # audio commands
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
    };
  };

  # services.hyprpaper = {
  #   enable = true;
  #   settings = {
  #     preload = [ "$config.stylix.image"];
  #     wallpaper = [ "$config.stylix.image"];      
  #   };
  # };

  # systemd.user.services.hyprpaper.Unit.After = lib.mkForce "graphical-session.target";

  # using nixvim now
  # imports = [
  #   ./nvim/nvim.nix
  # ];


  textfox = {
    enable = true;
    profile = "default";
    config = { displayHorizontalTabs = false; };
  };

  # services are background programs like hiding the mouse or making the
  # screen redder as night time approches.
  services = {
    hyprpaper.enable = true;

    # picom = {
    #   enable = true;
    #   backend = "glx";
    #   # this makes an aplication slightly transparent so you
    #   # can still see your background
    #   opacityRules = [ "85: class_g = 'Solvespace'" ];
    #   vSync = true;
    # };

    # This hides the mouse if you don't use it for a second
    # It is here because the mouse cursor annoys me
    # this doesn't work if you don't move a mouse
    # so a virtual event from python.mouse won't reshow cursor
    unclutter = {
      enable = true;
      timeout = 1;
    };

    flameshot = { enable = true; };

  };

  # This is where the programs will be defined
  # Programs with few options are defined here
  # Otherwise they will also have a config file
  # in the same directory
  programs = {
    kitty.enable = true;
    waybar = {
      enable = true;
      # use defualt style but if disable looks nice with window manager
      # matches color and looks like i3
      # style = ''
      #   ${builtins.readFile "${pkgs.waybar}/etc/xdg/waybar/style.css"}
      # '';
      settings = [{
        position = "bottom";
        layer    = "top";
        # can't get to work yet
        "custom/sepeartor" = {
          format = "|";
          interval = "once";
          tooltip = false;
        };
        modules-left  = [
          "hyprland/workspaces"
          "hyprland/submap"
        ];
        modules-center= [
          "hyprland/window"
        ];
        modules-right = [
          #"mpd"
          #"idle_indicator"
          "network"
          "pulseaudio"
          #"power-profiles-daemon"
          "cpu"
          "memory"
          "temperature"
          #"backlight"
          #"keyboard-state"
          #"battery"
          #"battery#bat2"
          "clock"
          #"tray"
          #"custom/power"
        ];
        pulseaudio = {
          format = "{volume}% vol";
        };
        clock = {
          format = "{:%d-%m-%Y | %H:%M}";
          tooltop = false;
          # tooltip-format = "{:%Y-%m-%d | %H:%M}";
        };
        cpu = {
          format = "{usage}% cpu";
          tooltip = false;
        };
        memory = { format = "{}% bat"; };
        network = {
          interval = 1;
          format-alt = "{ifname}: {ipaddr}/{cidr}";
          format-disconnected = "Disconnected ⚠";
          format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
          format-linked = "{ifname} (No IP) ";
          format-wifi = "{essid} ({signalStrength}%) ";
        };
      }];

    };
    tofi = {
      enable = true;


      settings = {
        # want big font              
        "font-size" =  lib.mkForce 30;
        #   # F2 is 95% opacity
        #   background-color = lib.mkForce "#000000F2";
      };
    };

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
      config = { showMatching = true; };
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

    # zathura = {
    #   enable = false;
    #   options = {
    #     recolor = true;
    # 	# overrwritten by stylix now
    #     # completion-bg = background;
    #     # completion-fg = foreground;
    #     # completion-group-bg = background;
    #     # completion-group-fg = color2;
    #     # completion-highlight-bg = foreground;
    #     # completion-highlight-fg = background;

    #     # recolor-lightcolor = background;
    #     # recolor-darkcolor = foreground;
    #     # default-bg = background;
    #     # inputbar-bg = background;
    #     # inputbar-fg = foreground;

    #     # notification-bg = background;
    #     # notification-fg = foreground;
    #     # notification-error-bg = color1;
    #     # notification-error-fg = foreground;
    #     # notification-warning-bg = color1;
    #     # notification-warning-fg = foreground;
    #     # statusbar-bg = background;
    #     # statusbar-fg = foreground;
    #     # index-bg = background;
    #     # index-fg = foreground;
    #     # index-active-bg = foreground;
    #     # index-active-fg = background;
    #     # render-loading-bg = background;
    #     # render-loading-fg = foreground;
    #   };
    # };

    firefox = {
      enable = true;
      profiles.default = {
        userChrome =
          "  fullscr-toggler { display:none!important; }\n  nav-bar[inFullscreen=\"true\"] { display:none!important; }\n  TabsToolbar[inFullscreen=\"true\"] { display:none!important; }\n";
      };
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
      autosuggestion.enable = true;
      enableCompletion = false;
      syntaxHighlighting.enable = true;
      autocd = true;
      initExtraBeforeCompInit = builtins.readFile ./zsh/zshrc;
    };

    # terminal multiplexer
    # tmux = {
    #   enable = true;
    #   baseIndex = 1;
    #   clock24 = true;
    #   shortcut = "a";
    #   keyMode = "vi";
    #   plugins = with pkgs.tmuxPlugins; [
    #     fingers
    #     {
    #       plugin = power-theme;
    #       extraConfig = "set -g @tmux_power_theme 'default'";
    #     }
    #     {
    #       plugin = continuum;
    #       extraConfig = ''
    #         set -g @continuum-restore 'on'
    #         set -g @continuum-save-interval '15' # minutes
    #       '';
    #     }

    #   ];
    #   extraConfig = builtins.readFile ./tmux/tmux.conf;
    # };

    # xmobar = {
    #   enable = true;
    #   # extraConfig = ./xmobarrc;
    # };

    # pressing super-p will bring up a application launcher with fuzzy finding.
    # using built in wmii instead
    rofi = { enable = true; };

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
