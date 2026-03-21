# Shared NixOS configuration across all dotfiles hosts
{ pkgs, ... }:
{
  nix.settings.download-buffer-size = 536870912; # 512 MB (default is 64 MB)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.systemd-boot.configurationLimit = 5;

  # AMD power management and display
  boot.kernelParams = [
    "amd_pstate=active"
    "amdgpu.dc=1"
  ];
  hardware.graphics.enable = true;

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "en_CA.UTF-8/UTF-8" ];
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

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
    wl-clipboard
    unzip
    zip
    gcc
    lxqt.lxqt-policykit
    pavucontrol
  ];

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
    ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "hutch" ];
  };

  system.stateVersion = "25.05";
}
