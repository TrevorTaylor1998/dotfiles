
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

let
  kmonad = import ./kmonad.nix;
in
{
  # imports =
  #   [ # Include the results of the hardware scan.
  #     # ./hardware-configuration.nix
  #   ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # boot.kernelPackages = pkgs.linuxPackages_latest;

  # boot.kernelPackages = pkgs.linuxPackages_4_19;

  # for steam
  nixpkgs.config = {
    allowUnfree = true;
    dyalog.acceptLicense = true;
    # this is for shen probably will cause problems later one
    #allowBroken = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking.hostName = "trevor-desktop"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  programs.steam.enable = true;
  programs.zsh.enable = true;
  programs.mosh.enable = true;

  # nixvim

  programs.nixvim = {
    enable = true;

    # options = {
    #   number = true;
    #   relativenumber = true;
    #   shiftwidth = 2;
    #   scrolloff = 5;
    #   colorcolumn = "80";
    #   widlmenu = true;
    #   expandtab = true;
    #   autoindent = true;
    #   splitbelow = true;
    #   splitright = true;
    # };

    globals.mapleader = " ";

    plugins = {
      telescope.enable = true;
      oil.enable = true;
      treesitter.enable = true;
      luasnip.enable = true;
      web-devicons.enable = true;
      mini.enable = true;
    };

    plugins.lsp = {
      enable = true;
      # servers = {
      #   lua_ls.enable = true;
      # 	rust_analyzer.enable = true;
      # 	};
    };
  };

  # stylix
  #stylix.enable = true;

  #home-manager.users.trevor = {
  #imports = [ inputs.hyprland.homeManagerModules.default ];
  stylix = {
    enable = true;
    autoEnable = true;
    # image = /home/trevor/Pictures/marisa.jpg;
    # image = /home/trevor/Pictures/pat_high.png;
    image = /home/trevor/Pictures/steins-gate.jpg;
    imageScalingMode = "fit";
    polarity = "dark";
    opacity.applications = 0.92;
    opacity.desktop = 0.92;
    opacity.popups = 0.92;
    opacity.terminal = 0.92;
    #homeManagerIntegration.autoImport := true;
    #homeManagerIntegration.followSystem = true;
    fonts = {
      monospace = {
        # nerd fonts was changed
        package = pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];};
        # package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font Mono";
      };
      # everything monospace hahahahahahaha
      serif = config.stylix.fonts.monospace;
      sansSerif = config.stylix.fonts.monospace;
      emoji = config.stylix.fonts.monospace;
      sizes = {
        terminal = 16;
      };
    };
  };
  # };

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  # networking.useDHCP = false;
  # networking.interfaces.enp0s31f6.useDHCP = true;
  # networking.interfaces.wlp0s20f0u9.useDHCP = true;
  # networking.interfaces.wlp4s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # i18n.inputMethod = {
  #   enabled = "fcitx5";
  #   #fcitx5.engines = with pkgs.fcitx-engines; [ mozc ];
  #   fcitx5.addons = with pkgs; [
  #     fcitx5-mozc
  #     fcitx5-gtk
  #     fcitx5-rime
  #     fcitx5-chinese-addons
  #     fcitx5-table-extra
  #   ];
  # };

  services.xserver.desktopManager.runXdgAutostartIfNone = true;

  # japanese stuff
  fonts.packages = with pkgs; [
    carlito
    dejavu_fonts
    ipafont
    kochi-substitute
    source-code-pro
    ttf_bitstream_vera
    fira-code
    fira-code-symbols
    jetbrains-mono
    comic-mono
    uiua386
  ];


  fonts.fontconfig.defaultFonts = {
    monospace = [
      "JetBrainsMono"
      # "ComicMono"
      # "Fira Code"
    ];
    # monospace = [
    #   "DejaVu Sans Mono"
    #   "IPAGothic"
    # ];
    # sansSerif = [
    #   "DejaVu Sans"
    #   "IPAPGothic"
    # ];
    # serif = [
    #   "DejaVu Serif"
    #   "IPAPMincho"
    # ];
  };

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;

  hardware.nvidia.open = true;

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  # hardware.opengl = {
  #   enable = true;
  #   driSupport32Bit = true;
  #   extraPackages = with pkgs; [
  #   mesa.drivers
  #   libglvnd
  #   libGL
  # ];
  #   setLdLibraryPath = true;
  # };


  # environment.variables = rec {
  #   VK_DRIVER_FILES=/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.x86_64.json;
  # };

  # systemd.services.nvidia-control-devices = {
  #   wantedBy = [ "multi-user.target" ];
  #   serviceConfig.ExecStart = "${pkgs.linuxPackages.nvidia_x11.bin}/bin/nvidia-smi";
  # };

  # changing trackpoint sensitivity
  hardware.trackpoint = {
    device = "Lite-On Tech IBM USB Travel Keyboard with Ultra Nav Mouse";
    enable = true;
    sensitivity = 250;
    speed = 200;
    emulateWheel = true;
  };

  hardware.keyboard.qmk.enable = true;

  # environment.extraInit = ''
  #   xset m 4 1
  # '';


  # remap keys
  # using X
  # services.xserver.xkb.options = "caps:super";

  # using wayland (or anything)
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = ["*"];
	      settings = {
	        main = {
	          capslock = "overload(meta, esc)";
	        };
	      };
      };
    };
  };


  # drawing tablet
  # services.xserver.digimend.enable = true;
  hardware.opentabletdriver.enable = true;

  #imports = [ inputs.hyprland.nixosModules.default ];
  

  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;
    xwayland.enable = true;
  };
  #programs.hyprland.package = inputs.hyprland.packages."${pkgs.system}".hyprland;
  #programs.hyprland.portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  hardware.nvidia.modesetting.enable = true;

  # services.xserver.windowManager.wmii = {
  #   enable = true;
  # };

  services.xserver.windowManager.i3 = {
    enable = true;
    extraPackages = with pkgs; [
      dmenu
      i3status
      i3lock
      i3blocks
    ];
  };

  services.openssh.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brgenml1lpr pkgs.brgenml1cupswrapper ];
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];

  # services.flatpak.enable = true;

  # Enable sound.
  #sound.enable = true;
  hardware.pulseaudio.enable = false;

  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;
  users.groups = { uinput = { }; };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.trevor = {
    isNormalUser = true;
    extraGroups = [ "wheel" "dialout" "uinput" "libvirtd" "jackaudio"]; # Enable ‘sudo’ for the user.
  };

  services.udev.extraRules =
    ''
                        # KMonad user access to /dev/uinput
                        KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
                      '';
  users.defaultUserShell = pkgs.zsh;
  environment.variables.EDITOR = "nvim";
  services.joycond.enable = true;
  # services.jack = {
  #   jackd.enable = true;
  #   alsa.enable = false;
  #   loopback = {
  #     enable = true;
  #   };
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    #cudatoolkit
    # orca-slicer

    #hyprland stuff
    hyprgui

    mako
    libnotify
    swww


    plover.dev
    wineWowPackages.stable
    winetricks
    wget
    #firefox
    vulkan-tools
    git
    # lutris
    # kmonad
    openal
    # spacenavd
    # spacenav-cube-example
    # joycond
    # spnavcfg
    # virt-manager
    #this is all part of a big hack to make common lisp work.
    #Probably not recommended
    libGL
    xorg.libX11
    xorg.libX11.dev
    glfw
    # glfw.dev
    SDL2
    SDL2_image
    libffi
    assimp
    gcc
    glibc
    pkg-config
    jmtpfs
  ];


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

