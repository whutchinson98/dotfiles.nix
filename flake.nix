{
  description = "dotfiles flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    # niri-waybar.url = "github:whutchinson98/niri-waybar";
  };
  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      niri,
      # niri-waybar,
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
            ./system/desktop/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit inputs system;
                # niri-waybar = inputs.niri-waybar;
                pkgs-stable = pkgs-stable;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.users.hutch = {
                imports = [ ./home/desktop/home.nix ];
              };
            }
          ];
        };
        "olympus" = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
          modules = [
            ./system/server/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit inputs system;
                # niri-waybar = inputs.niri-waybar;
                pkgs-stable = pkgs-stable;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.users.hutch = {
                imports = [ ./home/server/home.nix ];
              };
              home-manager.users.work = {
                imports = [ ./home/server/home.nix ];
              };
            }
          ];
        };
      };
    };
}
