# Pi

Configuration and extension sources for [pi](https://github.com/badlogic/pi-mono).

Pi reads agent-level prompt additions from `~/.pi/agent/APPEND_SYSTEM.md` and auto-discovers global extensions from `~/.pi/agent/extensions`. The home-manager module at `modules/home/dev/ai.nix` links `configs/pi/agent/APPEND_SYSTEM.md` and `configs/pi/extensions` there, the same way the Neovim module links `configs/nvim` into `~/.config/nvim`.

Add extensions as either:

- `extensions/my-extension.ts`
- `extensions/my-extension/index.ts` for multi-file extensions

After rebuilding home-manager/NixOS, run `/reload` inside pi to pick up changes.
