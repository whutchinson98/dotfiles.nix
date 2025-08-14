{ config, pkgs, ... }:

let nvimConfigPath = ../configs/nvim;
in {
  programs.neovim = { enable = true; };
  home.file.".config/nvim" = {
    source = nvimConfigPath;
    recursive = true;
  };
}
