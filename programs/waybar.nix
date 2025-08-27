{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        height = 24;
        spacing = 0;
        modules-left = [
          "clock"
          "hyprland/workspaces"
        ];
        modules-center = [ ];
        modules-right = [
          "tray"
          "custom/github"
          "pulseaudio"
          "memory"
          "temperature#cpu"
          "battery"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          format = "{name}: {icon}";
          format-icons = {
            "1" = "󰈹";
            "2" = "";
            "3" = "";
            "4" = "󰊯";
            "5" = "󰎚";
            "7" = "󰍡";
            "8" = "";
            "9" = "";
            "10" = "";
            urgent = "";
            focused = "";
            default = "";
          };
        };

        tray = {
          icon-size = 15;
          spacing = 8;
        };

        "custom/github" = {
          exec = "~/scripts/github-notifier.sh";
          interval = 60;
          return-type = "json";
        };

        clock = {
          tooltip-format = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          format = "{:%Y-%m-%d %H:%M}";
          interval = 60;
        };

        cpu = {
          format = "{usage}% ";
          tooltip = false;
        };

        memory = {
          format = "  {}%";
        };

        "temperature#cpu" = {
          hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
          critical-threshold = 70;
          format = " {temperatureC}°C";
          format-icons = [
            ""
            ""
            ""
          ];
        };

        "temperature#gpu" = {
          hwmon-path = "/sys/class/hwmon/hwmon1/temp1_input";
          critical-threshold = 80;
          format = "  {temperatureC}°C";
          format-icons = [
            ""
            ""
            ""
          ];
        };

        pulseaudio = {
          format = "{volume}% {icon} {format_source}";
          format-bluetooth = "{volume}% {icon} {format_source}";
          format-bluetooth-muted = " {icon} {format_source}";
          format-muted = " {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          format-icons = {
            default = [
              ""
              ""
              ""
            ];
          };
          on-click = "pavucontrol";
        };

        battery = {
          bat = "BAT1";
          interval = 60;
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          max-length = 25;
        };
      };
    };
    style = ''
      * {
        /* `otf-font-awesome` is required to be installed for icons */
        font-family:
          iosevka, Roboto, Helvetica, Arial, sans-serif, "Font Awesome 5 Free";
        font-size: 14px;
      }

      window#waybar {
        /*    background-color: rgba(43, 48, 59, 0.5);
          border-bottom: 3px solid rgba(100, 114, 125, 0.5);*/
        color: #a89984;
        background-color: #282828;
        /*    transition-property: background-color;
          transition-duration: .5s;*/
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      /*
      window#waybar.empty {
          background-color: transparent;
      }
      window#waybar.solo {
          background-color: #FFFFFF;
      }
      */

      /*window#waybar.termite {
          background-color: #3F3F3F;
      }
      window#waybar.chromium {
          background-color: #000000;
          border: none;
      }*/

      #workspaces button {
        padding: 0 10px;
        background-color: #282828;
        color: #ebdbb2;
        /* Use box-shadow instead of border so the text isn't offset */
        box-shadow: inset 0 -3px transparent;
        /* Avoid rounded borders under each workspace name */
        border: none;
        border-radius: 0;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      #workspaces button:hover {
        background: rgba(0, 0, 0, 0.2);
        /*    box-shadow: inset 0 -3px #fbf1c7;
      */
        background-color: #3c3836;
      }

      #workspaces button.focused {
        /*    box-shadow: inset 0 -3px #fbf1c7;
      */
        background-color: #3c3836;
        color: #ebdbb2;
      }

      #workspaces button.urgent {
        background-color: #fbf1c7;
        color: #3c3836;
      }

      #mode {
        background-color: #64727d;
        border-bottom: 3px solid #fbf1c7;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #custom-media,
      #tray,
      #mode,
      #idle_inhibitor,
      #custom-poweroff,
      #custom-suspend,
      #mpd {
        padding: 0 10px;
        background-color: #282828;
        color: #ebdbb2;
      }

      #window,
      #workspaces {
        margin: 0 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
      }

      #clock {
        color: #8ec07c;
      }

      #battery {
        color: #d3869b;
      }

      #battery.charging,
      #battery.plugged {
        color: #d3869b;
      }

      @keyframes blink {
        to {
          background-color: #fbf1c7;
          color: #df3f71;
        }
      }

      #battery.critical:not(.charging) {
        background-color: #282828;
        color: #d3869b;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
      }

      label:focus {
        background-color: #000000;
      }

      #backlight {
        color: #458588;
      }

      #temperature {
        color: #fabd2f;
      }

      #temperature.critical {
        background-color: #fbf1c7;
        color: #b57614;
      }

      #memory {
        color: #b8bb26;
      }

      #network {
        color: #fb4934;
      }

      #network.disconnected {
        background-color: #fbf1c7;
        color: #9d0006;
      }

      /*#disk {
          background-color: #964B00;
      }*/

      #pulseaudio {
        color: #fe8019;
      }

      #pulseaudio.muted {
        background-color: #fbf1c7;
        color: #af3a03;
      }

      #tray {
      }

      #tray > .needs-attention {
        background-color: #fbf1c7;
        color: #3c3836;
      }

      #idle_inhibitor {
        background-color: #282828;
        color: #ebdbb2;
      }

      #idle_inhibitor.activated {
        background-color: #fbf1c7;
        color: #3c3836;
      }

      #custom-media {
        background-color: #66cc99;
        color: #2a5c45;
        min-width: 100px;
      }

      #custom-media.custom-spotify {
        background-color: #66cc99;
      }

      #custom-media.custom-vlc {
        background-color: #ffa000;
      }

      #mpd {
        background-color: #66cc99;
        color: #2a5c45;
      }

      #mpd.disconnected {
        background-color: #f53c3c;
      }

      #mpd.stopped {
        background-color: #90b1b1;
      }

      #mpd.paused {
        background-color: #51a37a;
      }

      #language {
        background: #00b093;
        color: #740864;
        padding: 0 5px;
        margin: 0 5px;
        min-width: 16px;
      }

      #keyboard-state {
        background: #97e1ad;
        color: #000000;
        padding: 0 0px;
        margin: 0 5px;
        min-width: 16px;
      }

      #keyboard-state > label {
        padding: 0 5px;
      }

      #keyboard-state > label.locked {
        background: rgba(0, 0, 0, 0.2);
      }

      #custom-github {
        padding: 0 8px; /* Add horizontal padding */
        margin: 0 2px; /* Add a small margin between modules */
      }

      #custom-github.notification {
        color: #f85149; /* Red for notifications */
      }

      #custom-github.none {
        color: #8b949e; /* Gray for no notifications */
      }
    '';
  };
}
