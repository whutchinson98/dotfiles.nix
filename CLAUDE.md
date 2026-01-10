# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a NixOS flake-based configuration managing dotfiles and system configurations across multiple hosts. The repository uses a three-tier architecture: system-level NixOS configs, home-manager user configs, and reusable modules.

## Hosts

- **olympus**: Home server with dual users (`hutch` and `work`). SSH server enabled, Tailscale operator, Docker support.
- **zephyr**: Laptop with single user (`hutch`). Tailscale client connecting to olympus.

## Common Commands

### Building and Deploying
```bash
# Deploy to specific host
just switch .#zephyr
just switch .#olympus

# Or use nixos-rebuild directly
sudo nixos-rebuild switch --flake .#hostname

# Update flake dependencies
nix flake update
# or
just update
```

### Testing Changes
```bash
# Test configuration without switching
sudo nixos-rebuild test --flake .#hostname

# Build only (no activation)
sudo nixos-rebuild build --flake .#hostname
```

## Architecture

### Configuration Hierarchy

```
flake.nix (entry point)
  ├── system/{host}/configuration.nix (NixOS system config)
  │   └── system/{host}/hardware-configuration.nix
  └── home/{host}/home.nix (home-manager per user)
      └── modules/{terminal,desktop,dev-tools}.nix
          └── programs/{fish,helix,niri,waybar,...}.nix
```

### Module Organization

- **system/**: OS-level configurations (kernel, services, networking, users)
- **home/**: User-level entry points per host
- **modules/**: Reusable home-manager module groups
  - `terminal.nix`: CLI tools (fish, git, helix, tmux, starship)
  - `desktop.nix`: GUI applications and desktop services
  - `dev-tools.nix`: Development environment (AWS, Docker, Pulumi)
- **programs/**: Individual application configurations
- **configs/**: Raw config files and scripts referenced by Nix

### Special Arguments

Home-manager configs have access to:
- `inputs`: Flake inputs (nixpkgs, home-manager, zen-browser, niri)
- `system`: Architecture string ("x86_64-linux")
- `pkgs-stable`: Stable nixpkgs for select packages (DataGrip, Postman, Spotify)

## Key Design Patterns

### Dual Package Sets
The flake provides both `pkgs` (unstable) and `pkgs-stable` (25.11). Use `pkgs-stable` for packages requiring stability (JetBrains tools, media apps).

### Per-User Customization
- Git email changes based on `config.home.username`
- Olympus `work` user uses Neovim; `hutch` users use Helix
- Conditional imports allow user-specific tooling

### Host-Specific Configuration
- Olympus has SSH server, dual users, work-specific tools
- Zephyr has firmware updates (fwupd), single user
- Both share common modules but customize via imports

### Window Manager Setup (Niri)
- 8 categorized workspaces with specific apps auto-launching
- Workspaces: browser, code, db, recording, docs, chat, music, password
- Window rules in `programs/niri.nix`
- Waybar provides status bar with workspace indicators

## Important Files

- `flake.nix`: Defines inputs, outputs, and system configurations
- `flake.lock`: Pins exact dependency versions (auto-updated via GitHub Actions)
- `justfile`: Task runner with deployment shortcuts
- `system/{host}/configuration.nix`: OS settings, services, kernel parameters
- `home/{host}/home.nix`: User configuration entry point
- `modules/*.nix`: Shared configuration modules
- `programs/*.nix`: Individual program settings
- `configs/nvim/`: Neovim Lua configuration (referenced by `programs/neovim.nix`)
- `configs/scripts/`: Utility scripts (tmux-sessionizer, github-notifier)

## Development Environment

### Editor Configuration
- Helix: Configured with LSP servers for Rust, Nix, TypeScript, JSON, TOML
- Neovim: Optional, has Lua config in `configs/nvim/`
- Both have formatters configured (rustfmt, nixfmt)

### Shell Environment
- Fish shell with custom abbreviations and aliases
- Starship prompt with Git integration
- Tmux/Zellij for terminal multiplexing
- Custom scripts: `tmux-sessionizer` for project navigation

### Development Tools
- Docker with rootless mode
- AWS CLI v2 with completion
- Pulumi for infrastructure as code
- Cargo Lambda for AWS Lambda Rust development
- Railway CLI for deployments

## Modifying Configurations

### Adding a New Program
1. Create `programs/newprogram.nix` with home-manager module
2. Import in appropriate module (`terminal.nix`, `desktop.nix`, or `dev-tools.nix`)
3. Or import directly in `home/{host}/home.nix` for host-specific tools

### Adding a New Host
1. Create `system/newhostname/configuration.nix` and `hardware-configuration.nix`
2. Create `home/newhostname/home.nix`
3. Add `nixosConfiguration` entry in `flake.nix`
4. Add justfile shortcut (optional)

### Changing System Services
Edit `system/{host}/configuration.nix` for systemd services, kernel parameters, or system packages.

### Changing User Environment
Edit modules in `modules/` for shared changes, or `home/{host}/home.nix` for host-specific changes.

## Automated Updates

GitHub Actions runs daily at 7 AM EST:
- Executes `nix flake update`
- Creates PR with dependency updates
- Allows manual testing before merge

## Important Notes

- **AMD-optimized kernel**: Both hosts use `amd_pstate=active` and AMD microcode
- **Tailscale networking**: Olympus is operator/SSH server, Zephyr is client
- **1Password integration**: SSH agent, GUI, polkit for both users on Olympus
- **ZSA keyboard support**: Udev rules configured on Olympus
- **Wayland-only**: SDDM and Niri use Wayland (no X11)
- **PipeWire audio**: Replaces PulseAudio with better Bluetooth support
