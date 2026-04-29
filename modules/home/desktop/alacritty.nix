{
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        TERM = "screen-256color";
      };

      window = {
        decorations = "none";
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

      # Everforest Dark (Medium) — palette from helix everforest_dark theme
      colors = {
        primary = {
          background = "#2d353b";
          foreground = "#d3c6aa";
        };

        cursor = {
          text = "#2d353b";
          cursor = "#d3c6aa";
        };

        vi_mode_cursor = {
          text = "#2d353b";
          cursor = "#7fbbb3";
        };

        selection = {
          text = "CellForeground";
          background = "#475258";
        };

        normal = {
          black = "#475258";
          red = "#e67e80";
          green = "#a7c080";
          yellow = "#dbbc7f";
          blue = "#7fbbb3";
          magenta = "#d699b6";
          cyan = "#83c092";
          white = "#d3c6aa";
        };

        bright = {
          black = "#56635f";
          red = "#e67e80";
          green = "#a7c080";
          yellow = "#dbbc7f";
          blue = "#7fbbb3";
          magenta = "#d699b6";
          cyan = "#83c092";
          white = "#d3c6aa";
        };
      };
    };
  };
}
