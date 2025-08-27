{ pkgs, ... }:

let
  nvimConfigPath = ../configs/nvim;
in
{
  programs.neovim = {
    enable = true;
  };

  home.packages = with pkgs; [
    nixd
    nixfmt-rfc-style
    tree-sitter
  ];

  home.file.".config/nvim" = {
    source = nvimConfigPath;
    recursive = true;
  };
}
