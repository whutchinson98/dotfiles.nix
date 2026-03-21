# Terminal and CLI tools
{ pkgs, ... }:
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
    kubectl
    kubernetes-helm
    fluxcd
    hugo
  ];
}
