{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ fnm rustup ];
}
