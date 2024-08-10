
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  kmonad = import ./kmonad.nix;
in
{
  # imports =
  #   [ # Include the results of the hardware scan.
  #     # ./hardware-configuration.nix
  #   ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;
    
 # boot.kernelPackages = pkgs.linuxPackages_4_19;

  # for steam
  nixpkgs.config = {
    allowUnfree = true;
    # this is for shen probably will cause problems later one
    #allowBroken = true;
  };

  nix = {
    package = pkgs.nixFlakes; # or versioned attributes like nixVersions.nix_2_8
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  #  hardware.firmware = [
  #    (
  #      pkgs.runCommandNoCC "

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

  i18n.inputMethod = {
    enabled = "fcitx5";
    #fcitx5.engines = with pkgs.fcitx-engines; [ mozc ];
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
      fcitx5-rime
      fcitx5-chinese-addons
      fcitx5-table-extra
    ];
  };

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
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;
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
  # services.xserver.xkbOptions = "caps:super";

  # services.interception-tools = {
  #   enable = true;
  #   plugins = [ pkgs.interception-tools-plugins.dual-function-keys ];
  #   # - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc -m 1 | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
  #   udevmonConfig = ''
  #   - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c /etc/dual-function-keys.yaml | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
  #     DEVICE:
  #       EVENTS:
  #         EV_KEY: [KEY_LEFTCTRL, KEY_LEFTALT, KEY_CAPSLOCK, KEY_RIGHTSHIFT, KEY_LEFTSHIFT]
  #   '';
  # };

  # # using a realtive path name didn't work for some reason have to use absolute
  # environment.etc."dual-function-keys.yaml".text = builtins.readFile "/home/trevor/github/dotfiles/dual-function-keys.yaml";


  # services.xserver = {
  #     xkbOptions = "compose:ralt";
  #     layout = "us";
  #   };

  # drawing tablet
  # services.xserver.digimend.enable = true;
  hardware.opentabletdriver.enable = true;


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

  # services.xserver = {
  #   enable = true;
  #   windowManager.exwm = {
  #       enable = true;
  #       enableDefaultConfig = false;
  #       extraPackages = epkgs: [
  #         epkgs.emacsql-sqlite
  #         epkgs.vterm
  #         epkgs.magit
  #         epkgs.pdf-tools
  #         pkgs.python3
  #       ];
  #     };

  #   displayManager.lightdm = {
  #     enable = true;
  #     greeters.enso = {
  #       enable = true;
  #       blur = true;
  #     };
  #   };

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
  services.avahi.nssmdns = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;

  # xdg.portal.enable = true;
  # services.flatpak.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
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
    plover.dev
    wineWowPackages.stable
    winetricks
    wget
    firefox
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

