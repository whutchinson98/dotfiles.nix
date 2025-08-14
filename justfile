[no-cd]
switch *ARGS:
    sudo nixos-rebuild switch --flake {{ARGS}}

switch_zephyr:
  just switch .#zephyr

switch_olympus:
  just switch .#olympus
