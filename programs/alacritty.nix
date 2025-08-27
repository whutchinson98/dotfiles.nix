{
  programs.alacritty = {
    enable = true;

    settings = {
      env = {
        TERM = "screen-256color";
      };

      font = {
        size = 10;
        normal = {
          family = "Noto Sans Mono";
          style = "Regular";
        };
        bold = {
          family = "Noto Sans Mono";
          style = "Bold";
        };
        italic = {
          family = "Noto Sans Mono";
          style = "Italic";
        };
      };

      selection = {
        save_to_clipboard = true;
      };

      terminal = {
        osc52 = "CopyPaste";
      };

      keyboard = {
        bindings = [
          {
            key = "Space";
            mods = "Control";
            action = "ToggleViMode";
          }
        ];
      };

      # Gruvbox Dark theme
      colors = {
        primary = {
          background = "#282828";
          foreground = "#ebdbb2";
        };

        normal = {
          black = "#282828";
          red = "#cc241d";
          green = "#98971a";
          yellow = "#d79921";
          blue = "#458588";
          magenta = "#b16286";
          cyan = "#689d6a";
          white = "#a89984";
        };

        bright = {
          black = "#928374";
          red = "#fb4934";
          green = "#b8bb26";
          yellow = "#fabd2f";
          blue = "#83a598";
          magenta = "#d3869b";
          cyan = "#8ec07c";
          white = "#ebdbb2";
        };
      };
    };
  };
}
