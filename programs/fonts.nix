{ pkgs, ... }:
{
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    font-awesome # For icons in waybar, etc.
    nerd-fonts.space-mono
  ];
}
