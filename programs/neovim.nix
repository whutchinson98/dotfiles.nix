{ config, pkgs, ... }:

let nvimConfigPath = ../configs/nvim;
in {
  programs.neovim = { enable = true; };

  home.packages = with pkgs; [ 
    nixd 
    nixfmt-rfc-style 
  ];

  home.file.".config/nvim" = {
    source = nvimConfigPath;
    recursive = true;
  };
}
