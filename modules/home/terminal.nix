# Terminal and CLI tools
{ pkgs, inputs, ... }:
{
  imports = [
    ./terminal/fish.nix
    ./terminal/git.nix
    ./terminal/helix.nix
    ./terminal/jujutsu.nix
    ./terminal/ripgrep.nix
    ./terminal/scripts.nix
    ./terminal/starship.nix
    ./terminal/tmux.nix
    ./terminal/yazi.nix
    ./terminal/zellij.nix
  ];

  home.packages = with pkgs; [
    eza
    fzf
    just
    jq
    inputs.thrum.packages.${pkgs.stdenv.hostPlatform.system}.default
    kubectl
    flux
    hugo
  ];
}
