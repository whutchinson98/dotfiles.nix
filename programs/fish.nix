{ config, pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAbbrs = {
      # Basic aliases
      c = "clear";
      ls = "eza --long --git --icons --all";
      l = "ls";

      # Git aliases
      gp = "git push";
      gpu = "git pull";
      gs = "git status";
      glo = "git log --oneline";
      gwtc = "git config --get remote.origin.fetch";
      gwtf = ''
        git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"'';
      cleangit =
        "git branch | awk '{print $1}' | xargs git branch -D && git fetch -p";
      gitlfsfix = "git rm --cached -r . && git reset --hard";

      # Cargo aliases
      cb = "cargo build";
      cbr = "cargo build --release";
      cr = "cargo run";
      ct = "cargo test";
    };

    shellInit = ''
      # Disable fish greeting
      set -U fish_greeting ""

      # Environment variables
      set -gx TERM screen-256color
      set -gx GO_PATH $HOME/go/bin
      set -gx DOCKER_GATEWAY_HOST 172.17.0.1
      set -gx NVIM (which nvim)
      set -gx RIPGREP_CONFIG_PATH $HOME/.ripgreprc
      set -gx EDITOR "nvim"

      # Bun configuration
      set --export BUN_INSTALL "$HOME/.bun"
      set --export PATH $BUN_INSTALL/bin $PATH

      # Add paths
      fish_add_path "$CARGO_HOME/bin"
      fish_add_path $HOME/bin /usr/local/bin $HOME/.local/bin
      fish_add_path $HOME/.pulumi/bin
      fish_add_path $PNPM_HOME

      # Conditional path additions
      test -d $GO_PATH; and fish_add_path $GO_PATH
      test -d $JAVA_HOME/bin; and fish_add_path $JAVA_HOME/bin
      test -d $DOTNET_ROOT; and fish_add_path $DOTNET_ROOT

      # Key bindings
      bind \cf 'fish -c "~/scripts/tmux-sessionizer"'

      # Initialize tools
      starship init fish | source

      # Rustup/Cargo setup
      if test -d "$HOME/.cargo"
        set PATH "$HOME/.cargo/bin" $PATH
      end

      # Nix setup
      if test -e $HOME/.nix-profile/etc/profile.d/nix.fish
        source $HOME/.nix-profile/etc/profile.d/nix.fish
      end
    '';

    interactiveShellInit = ''
      # Additional interactive shell configuration can go here
    '';
  };
}
