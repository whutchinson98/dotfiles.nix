#!/bin/bash

echo "This will remove all Neovim data:"
echo "  ~/.local/share/nvim"
echo "  ~/.local/state/nvim" 
echo "  ~/.cache/nvim"
echo
read -p "Are you sure? (y/N): " confirm
case "$confirm" in
    [yY]|[yY][eE][sS])
        echo "Removing Neovim data..."
        rm -rf ~/.local/share/nvim
        rm -rf ~/.local/state/nvim
        rm -rf ~/.cache/nvim
        echo "Done."
        ;;
    *)
        echo "Cancelled."
        exit 1
        ;;
esac
