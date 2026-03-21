switch:
    sudo nixos-rebuild switch --flake .#$(hostname)

update:
    nix flake update
