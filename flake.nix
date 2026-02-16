{
  description = "dotfiles flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    playwright-web-flake.url = "github:pietdevries94/playwright-web-flake";
    thrum = {
      url = "github:whutchinson98/thrum";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      playwright-web-flake,
      thrum,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      pkgs-stable = import nixpkgs-stable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        "zephyr" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            { nixpkgs.hostPlatform = "x86_64-linux"; }
            ./system/zephyr/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit inputs;
                pkgs-stable = pkgs-stable;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.users.hutch = {
                imports = [ ./home/zephyr/home.nix ];
              };
            }
          ];
        };
        "olympus" = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; };
          modules = [
            { nixpkgs.hostPlatform = "x86_64-linux"; }
            ./system/olympus/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit inputs;
                pkgs-stable = pkgs-stable;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.users.hutch = {
                imports = [ ./home/olympus/home.nix ];
              };
            }
          ];
        };
      };
    };
}
