{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.niri.homeModules.niri
  ];

  home.packages = with pkgs; [
    swaylock
    fuzzel
    xwayland-satellite
    swww
  ];

  programs.niri = {
    package = pkgs.niri.overrideAttrs (old: {
      doCheck = false;
    });

    settings = {
      input = {
        keyboard = {
          xkb = { };
          numlock = true;
        };

        touchpad = {
          tap = true;
          natural-scroll = true;
        };
      };

      layout = {
        gaps = 16;
        center-focused-column = "never";

        preset-column-widths = [
          { proportion = 0.33333; }
          { proportion = 0.5; }
          { proportion = 0.66667; }
        ];

        default-column-width = {
          proportion = 0.5;
        };

        focus-ring = {
          enable = true;
          width = 4;
        };

        border = {
          enable = false;
        };
      };

      spawn-at-startup = [
        {
          command = [
            "sh"
            "-c"
            "swww-daemon && swww img $HOME/backgrounds/gruvbox_astro.jpg"
          ];
        }
        { command = [ "waybar" ]; }
        { command = [ "xwayland-satellite" ]; }
        { command = [ "zen" ]; }
        { command = [ "alacritty" ]; }
        { command = [ "obsidian" ]; }
        { command = [ "1password" ]; }
      ];

      environment = {
        DISPLAY = ":0";
      };

      screenshot-path = "~/screenshots/%Y-%m-%d %H-%M-%S.png";

      workspaces = {
        "browser" = { };
        "code" = { };
        "db" = { };
        "recording" = { };
        "docs" = { };
        "chat" = { };
        "music" = { };
        "password" = { };
      };

      window-rules = [
        {
          matches = [ { app-id = "Alacritty"; } ];
          open-on-workspace = "code";
        }
        {
          matches = [ { app-id = "zen"; } ];
          open-on-workspace = "browser";
        }
        {
          matches = [ { app-id = "Postman"; } ];
          open-on-workspace = "db";
          open-focused = true;
        }
        {
          matches = [ { app-id = "jetbrains-datagrip"; } ];
          open-on-workspace = "db";
          open-focused = true;
        }
        {
          matches = [ { app-id = "com.obsproject.Studio"; } ];
          open-on-workspace = "recording";
        }
        {
          matches = [ { app-id = "obsidian"; } ];
          open-on-workspace = "docs";
          open-focused = true;
        }
        {
          matches = [ { app-id = "signal"; } ];
          open-on-workspace = "chat";
          open-focused = true;
        }
        {
          matches = [ { app-id = "discord"; } ];
          open-on-workspace = "chat";
          open-focused = true;
        }
        {
          matches = [ { app-id = "Proton Mail"; } ];
          open-on-workspace = "chat";
          open-focused = true;
        }
        {
          matches = [ { app-id = "Spotify"; } ];
          open-on-workspace = "music";
          open-focused = true;
        }
        {
          matches = [ { app-id = "1Password"; } ];
          open-on-workspace = "password";
        }
      ];

      binds = {
        "Super+O".action.toggle-overview = { };
        "Mod+Shift+Slash".action.show-hotkey-overlay = { };
        "Mod+T".action.spawn = [ "alacritty" ];
        "Mod+P".action.spawn = [ "fuzzel" ];
        "Super+Alt+L".action.spawn = [ "swaylock" ];

        "Mod+Q".action.close-window = { };

        "Mod+H".action.focus-column-left = { };
        "Mod+J".action.focus-window-down = { };
        "Mod+K".action.focus-window-up = { };
        "Mod+L".action.focus-column-right = { };

        "Mod+Ctrl+H".action.move-column-left = { };
        "Mod+Ctrl+J".action.move-window-down = { };
        "Mod+Ctrl+K".action.move-window-up = { };
        "Mod+Ctrl+L".action.move-column-right = { };

        "Mod+1".action.focus-workspace = "browser";
        "Mod+2".action.focus-workspace = "code";
        "Mod+3".action.focus-workspace = "db";
        "Mod+4".action.focus-workspace = "recording";
        "Mod+5".action.focus-workspace = "docs";
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = "chat";
        "Mod+8".action.focus-workspace = "music";
        "Mod+9".action.focus-workspace = "password";

        "Mod+Shift+1".action.move-column-to-workspace = "browser";
        "Mod+Shift+2".action.move-column-to-workspace = "code";
        "Mod+Shift+3".action.move-column-to-workspace = "db";
        "Mod+Shift+4".action.move-column-to-workspace = "recording";
        "Mod+Shift+5".action.move-column-to-workspace = "docs";
        "Mod+Shift+6".action.move-column-to-workspace = 6;
        "Mod+Shift+7".action.move-column-to-workspace = "chat";
        "Mod+Shift+8".action.move-column-to-workspace = "music";
        "Mod+Shift+9".action.move-column-to-workspace = "password";

        "Mod+F".action.maximize-column = { };
        "Mod+Shift+F".action.fullscreen-window = { };
        "Mod+B".action.screenshot = { };
        "Mod+Shift+E".action.quit = { };
      };
    };
  };
}
