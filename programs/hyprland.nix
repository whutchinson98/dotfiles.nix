{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprpaper
    hyprlock
    hypridle
    brightnessctl
  ];

  home.pointerCursor = {
    enable = true;
    name = "Bibata-Modern-Classic";  # Use the actual theme name
    package = pkgs.bibata-cursors;   # Use the cursor theme package
    size = 24;
    hyprcursor = {
      enable = true;
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # Ecosystem
      "ecosystem:no_update_news" = true;

      # Monitors
      monitor = [ "eDP-1,2256x1504@60,auto,1.0" ",preferred,auto,auto" ];

      # Workspace monitor assignments
      workspace = [
        "1, monitor:DP-4"
        "2, monitor:DP-4"
        "3, monitor:DP-4"
        "4, monitor:DP-4"
        "5, monitor:DP-4"
        "6, monitor:DP-4"
        "7, monitor:DP-4"
        "8, monitor:DP-4"
        "9, monitor:DP-4"
        "10, monitor:DP-4"
        "11, monitor:eDP-1"
      ];

      # Programs
      "$browser" = "zen";
      "$terminal" = "alacritty";
      "$notes" = "obsidian";
      "$tickets" = "linear-desktop";
      "$fileManager" = "dolphin";
      "$menu" = "rofi -show combi -combi-modi 'run,drun' -modi combi";
      # wofi --show drun,run --allow-images --image-size 20 --allow-markup --insensitive

      # Autostart
      exec-once = [
        "systemctl --user start pipewire.service && systemctl --user start pipewire-pulse.service && systemctl --user start wireplumber.service"
        "sleep 2 && wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && sleep 0.5 && wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        "waybar & hyprpaper"
        "nm-applet"
        "$browser & $terminal & 1password & $notes"
      ];

      # Environment variables
      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
      ];

      # General settings
      general = {
        gaps_in = 4;
        gaps_out = 10;
        border_size = 2;
        "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = "rgba(595959aa)";
        resize_on_border = false;
        allow_tearing = false;
        layout = "dwindle";
      };

      # Decoration
      decoration = {
        rounding = 2;
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = false;
          range = 4;
          render_power = 3;
          color = "rgba(1a1a1aee)";
        };

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      # Animations
      animations = {
        enabled = "yes, please :)";

        bezier = [
          "easeOutQuint,0.23,1,0.32,1"
          "easeInOutCubic,0.65,0.05,0.36,1"
          "linear,0,0,1,1"
          "almostLinear,0.5,0.5,0.75,1.0"
          "quick,0.15,0,0.1,1"
        ];

        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
        ];
      };

      # Dwindle layout
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # Master layout
      master = { new_status = "master"; };

      # Misc
      misc = {
        force_default_wallpaper = -1;
        disable_hyprland_logo = false;
      };

      # Input
      input = {
        kb_layout = "us";
        kb_variant = "";
        kb_model = "";
        kb_options = "";
        kb_rules = "";
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = { natural_scroll = false; };
      };

      # Gestures
      gestures = { workspace_swipe = false; };

      # Device config
      device = {
        name = "epic-mouse-v1";
        sensitivity = -0.5;
      };

      # Main modifier
      "$mainMod" = "SUPER";

      # Key bindings
      bind = [
        # Program launches
        "$mainMod, T, exec, $terminal"
        "$mainMod, N, exec, $notes"
        "$mainMod ALT, L, exec, $tickets"
        "$mainMod, Z, exec, $browser"

        # Window management
        "$mainMod SHIFT, C, killactive,"
        "$mainMod SHIFT, Q, exit,"
        "$mainMod SHIFT, S, exec, swaylock -f && loginctl suspend"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating,"
        "$mainMod, P, exec, $menu"
        "$mainMod SHIFT, J, togglesplit,"
        "$mainMod, B, exec, hyprshot -m region --clipboard-only"
        "$mainMod, F, fullscreen"

        # Focus movement
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, K, movefocus, u"
        "$mainMod, J, movefocus, d"

        # Workspace switching
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move to workspace
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"
      ];

      # Media and laptop keys
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      # Media control
      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      # Mouse bindings
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Window rules
      windowrule = [
        "workspace 1, class:^(zen-beta|firefox-developer-edition)$"
        "workspace 3, class:^(Postman)$"
        "workspace 3, class:^(jetbrains-datagrip)$"
        "workspace 5, class:^(obsidian)$"
        "workspace 6, class:^(linear*)$"
        "workspace 7, class:^(Signal|discord|Proton Mail)$"
        "workspace 8, class:^(Spotify)$"
        "workspace 9, class:^(1Password)$"
        "workspace 10, class:^(Slack)$"
      ];

      windowrulev2 = [
        "workspace 2, class:^(Alacritty|com.mitchellh.ghostty)$"
        "suppressevent maximize, class:.*"
        "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
      ];
    };
  };

  # Hyprpaper configuration
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "~/backgrounds/gruvbox_astro.jpg" ];
      wallpaper = [ ",~/backgrounds/gruvbox_astro.jpg" ];
    };
  };
}
