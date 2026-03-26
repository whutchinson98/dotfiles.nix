{
  description = "dotfiles flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };

      # Helper to reduce boilerplate per host
      mkHost =
        hostname: extraModules:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            { nixpkgs.hostPlatform = system; }
            ./hosts/common.nix
            ./hosts/${hostname}/configuration.nix
            ./hosts/${hostname}/hardware-configuration.nix
            ./modules/system/audio.nix
            ./modules/system/desktop.nix
            ./modules/system/docker.nix
            ./modules/system/keyboard.nix
            ./modules/system/fingerprint.nix
            ./modules/system/tailscale.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = { inherit inputs pkgs-stable; };
              home-manager.useGlobalPkgs = true;
              home-manager.users.hutch.imports = [ ./hosts/${hostname}/home.nix ];
            }
          ]
          ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        zephyr = mkHost "zephyr" [
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
        ];
        olympus = mkHost "olympus" [ ];
      };
    };
}
