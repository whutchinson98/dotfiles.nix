{ config, pkgs, ... }:

{
  imports = [
    ../programs/pulumi.nix
    ../programs/direnv.nix
    ../programs/claude_code.nix
  ];
  home.packages = with pkgs; [
    nixd
    nixfmt
    awscli2
    doppler
    docker-compose
    cargo-lambda
    atac
    sops
  ];
}
