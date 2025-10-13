{
  description = "dotfiles flake";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    niri-waybar.url = "github:whutchinson98/niri-waybar";
    # github-notifier = {
    #   url = "github:whutchinson98/github-notifier";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      niri,
      niri-waybar,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
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
                niri-waybar = inputs.niri-waybar;
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
              home-manager.extraSpecialArgs = { inherit inputs; };
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

      # Development shell for dotfiles
      devShells.${system}.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          # Nix development
          nil # Modern Nix LSP (replaces rnix-lsp)
          nixpkgs-fmt # Nix formatter

          # Lua development
          lua-language-server
          stylua

          # build tools
          just
        ];

        shellHook = ''
          echo "🚀 Dotfiles development environment loaded!"
          echo "Available tools:"
          echo "  - nil (Nix LSP)"
          echo "  - nixpkgs-fmt (Nix formatter)"
          echo "  - lua-language-server (lua_ls)"
          echo "  - stylua (Lua formatter)"
        '';
      };
    };
}
