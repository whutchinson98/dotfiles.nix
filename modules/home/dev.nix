# Development tools
{ pkgs, ... }:
{
  imports = [
    ./dev/claude-code.nix
    ./dev/direnv.nix
    ./dev/pulumi.nix
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
    age
    ssh-to-age
    gh
  ];
}
