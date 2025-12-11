{ pkgs, ... }:
{

  # Font rendering configuration
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      monospace = [ "Noto Sans Mono" ];
      sansSerif = [ "Noto Sans" ];
      serif = [ "Noto Serif" ];
    };
  };

  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    font-awesome # For icons in waybar, etc.
    nerd-fonts.space-mono
  ];
}
