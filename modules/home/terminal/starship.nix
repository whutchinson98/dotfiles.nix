{
  programs.starship = {
    enable = true;
    settings = {
      # Global settings
      command_timeout = 30000;
      scan_timeout = 10;
      add_newline = false;

      # Custom format
      format =
        "$os$hostname$nix_shell$directory$fill$cmd_duration $time$line_break$character";

      nix_shell = {
        impure_msg = "[impure shell](bold red)";
        pure_msg = "[pure shell](bold green)";
        unknown_msg = "[unknown shell](bold yellow)";
        format = "via [☃️ $state( \($name\))](bold blue) ";
      };

      # OS configuration
      os = {
        format = "$symbol";
        disabled = false;
        symbols = {
          Macos = " ";
          Arch = "󰣇 ";
          NixOS = " ";
        };
      };

      # Hostname configuration
      hostname = {
        disabled = false;
        ssh_only = false;
        format = "[$hostname](bold blue)";
      };

      # Fill configuration
      fill = { symbol = " "; };

      # Character configuration
      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[✗](bold red)";
      };

      # Directory configuration
      directory = {
        truncate_to_repo = false;
        read_only = "🔒";
      };

      # Package configuration
      package = { disabled = true; };

      # Git status configuration
      git_status = {
        untracked = "[++\\($count\\)](red)";
        modified = "[++\\($count\\)](yellow)";
        staged = "[++\\($count\\)](green)";
      };
    };
  };
}
