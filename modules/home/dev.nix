# Development tools
{ pkgs, ... }:
{
  imports = [
    ./dev/claude-code.nix
    ./dev/direnv.nix
    ./dev/pulumi.nix
    ./dev/terraform.nix
    ./dev/aws.nix
    ./dev/github.nix
  ];

  home.packages = with pkgs; [
    nixd
    nixfmt
    awscli2
    doppler
    docker-compose
    sops
    age
    ssh-to-age
  ];
}
