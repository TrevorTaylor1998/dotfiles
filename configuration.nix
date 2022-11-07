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

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # for steam
  nixpkgs.config = {
    allowUnfree = true;
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

  networking.hostName = "trevor-desktop"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Los_Angelos";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s31f6.useDHCP = true;
  #networking.interfaces.wlp0s20f0u9.useDHCP = true;
  networking.interfaces.wlp4s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # japanese stuff
  fonts.fonts = with pkgs; [
    carlito
    dejavu_fonts
    ipafont
    kochi-substitute
    source-code-pro
    ttf_bitstream_vera
    fira-code
    fira-code-symbols
    jetbrains-mono
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [
      "JetBrainsMono"
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
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.opengl.driSupport32Bit = true;

  # changing trackpoint sensitivity
  hardware.trackpoint = {
    device = "Lite-On Tech IBM USB Travel Keyboard with Ultra Nav Mouse";
    enable = true;
    sensitivity = 250;
    speed = 200;
    emulateWheel = true;
  };

  # environment.extraInit = ''
  #   xset m 4 1
  # '';


  # remap keys
  services.xserver.xkbOptions = "caps:super";

  # services.xserver = {
  #     xkbOptions = "compose:ralt";
  #     layout = "us";
  #   };

  # drawing tablet
  services.xserver.digimend.enable = true;



  # Enable the GNOME Desktop Environment.
  #services.xserver.displayManager.gdm.enable = true;
  #services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.windowManager.xmonad = {
  #   enable = true;
  #   enableContribAndExtras = true;
  #   };
  services.xserver.windowManager.wmii = {
    enable = true;
  };

  services.openssh.enable = true;

  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;
  users.groups = { uinput = { }; };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.trevor = {
    isNormalUser = true;
    extraGroups = [ "wheel" "dialout" "uinput" "libvirtd" ]; # Enable ‘sudo’ for the user.
  };

  services.udev.extraRules =
    ''
      # KMonad user access to /dev/uinput
      KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
    '';
  users.defaultUserShell = pkgs.zsh;
  environment.variables.EDITOR = "nvim";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    firefox
    vulkan-tools
    git
    lutris
    kmonad
    spacenavd
    spacenav-cube-example
    spnavcfg
    virt-manager
  ];

  programs.steam.enable = true;
  programs.mosh.enable = true;

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

