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
    playwright-web-flake.url = "github:pietdevries94/playwright-web-flake";
  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      playwright-web-flake,
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
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./system/zephyr/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit inputs system;
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
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./system/olympus/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit inputs system;
                pkgs-stable = pkgs-stable;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.users.hutch = {
                imports = [ ./home/olympus/home.nix ];
              };
              home-manager.users.work = {
                imports = [ ./home/olympus/home.nix ];
              };
            }
          ];
        };
      };
    };
}
