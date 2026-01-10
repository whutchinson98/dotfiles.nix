{ config, pkgs, ... }:

{
  imports = [
    ../programs/pulumi.nix
    ../programs/direnv.nix
  ];
  home.packages = with pkgs; [
    awscli2
    doppler
    docker-compose
    cargo-lambda
    claude-code
    atac
    railway
  ];
}
