{ config, pkgs, ... }:

{
  imports = [
    ../programs/fish.nix
    ../programs/git.nix
    ../programs/neovim.nix
    ../programs/ripgrep.nix
    ../programs/scripts.nix
    ../programs/starship.nix
    ../programs/tmux.nix
    ../programs/zellij.nix
    ../programs/yazi.nix
    ../programs/jujutsu.nix
  ];
  home.packages = with pkgs; [
    eza
    fzf
    just
  ];
}
