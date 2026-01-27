# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  pkgs-stable,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings.download-buffer-size = 536870912; # 512 MB (default is 64 MB)

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Use the latest kernel for better AMD support
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # AMD graphics configuration
  hardware.graphics = {
    enable = true;
  };

  # AMD specific kernel parameters
  boot.kernelParams = [
    "amd_pstate=active" # Better AMD power management
    "amdgpu.dc=1" # Enable Display Core
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "olympus"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };
  # Also clean up user profiles
  nix.settings.auto-optimise-store = true;

  boot.loader.systemd-boot.configurationLimit = 5;

  users.groups.docker = { };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hutch = {
    isNormalUser = true;
    description = "hutch";
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "disk"
      "storage"
      "input"
      "audio"
      "docker"
      "plugdev"
    ];
    shell = pkgs.fish;
  };

  services.udev.packages = [
    pkgs.ledger-udev-rules
  ];

  # Create the udev rules
  services.udev.extraRules = ''
    # Rules for Oryx web flashing and live training
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

    # Legacy rules for live training over webusb (Not needed for firmware v21+)
    # Rule for all ZSA keyboards
    SUBSYSTEM=="usb", ATTRS{idVendor}=="3297", GROUP="plugdev"
    # Rule for the Moonlander
    SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
    # Rule for the Ergodox EZ
    SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
    # Rule for the Planck EZ
    SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

    # Wally Flashing rules for the Ergodox EZ
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[17]89B[?]", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[17]89A[?]", ENV{MTP_NO_PROBE}="1"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[17]89ABCD[?]", MODE="0666"
    KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[17]89B[?]", MODE="0666"

    # Keymapp / Wally Flashing rules for the Moonlander and Planck EZ
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE="0666", SYMLINK+="stm32_dfu"
    # Keymapp Flashing rules for the Voyager
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE="0666", SYMLINK+="ignition_dfu"
  '';

  # Create the plugdev group
  users.groups.plugdev = { };

  programs.fish.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    wl-clipboard
    unzip
    zip
    gcc
    lxqt.lxqt-policykit # Lightweight polkit agent
    pavucontrol
    docker
    docker-buildx
  ];

  # Docker
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = true;
  virtualisation.docker.autoPrune.enable = true;
  virtualisation.docker.rootless.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:
  services.tailscale = {
    enable = true;
    extraUpFlags = [
      "--ssh"
      "--operator=hutch"
    ];
  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [
      "hutch"
    ];
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  # programs.hyprland = {
  #   enable = true;
  #   xwayland.enable = true;
  # };

  # enable niri at a system level so it's picked up by SDDM
  programs.niri.enable = true;

  services.dbus.enable = true;
  security.polkit.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # xdg.portal = {
  #   enable = true;
  #   xdgOpenUsePortal = true;
  #   extraPortals = with pkgs; [
  #     xdg-desktop-portal-hyprland
  #   ];
  #   config = {
  #     common.default = "hyprland";
  #     niri = {
  #       default = "hyprland";
  #       "org.freedesktop.impl.portal.ScreenCast" = "hyprland";
  #       "org.freedesktop.impl.portal.Screenshot" = "hyprland";
  #     };
  #   };
  # };

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
  system.stateVersion = "25.05"; # Did you read the comment?

}
