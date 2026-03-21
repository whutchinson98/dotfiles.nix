{ pkgs, ... }:

let
  nvimConfigPath = ../configs/nvim;
in
{
  programs.neovim = {
    enable = true;
  };

  home.packages = with pkgs; [
    tree-sitter
  ];

  home.file.".config/nvim" = {
    source = nvimConfigPath;
    recursive = true;
  };
}
