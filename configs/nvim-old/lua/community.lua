-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.motion.harpoon" },
  { import = "astrocommunity.completion.supermaven-nvim" },
  { import = "astrocommunity.completion.magazine-nvim" },
  -- { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.recipes.vscode-icons" },
  -- { import = "astrocommunity.pack.typescript" },
  { import = "astrocommunity.colorscheme.gruvbox-nvim" },
  -- { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.recipes.neovide" },
  { import = "astrocommunity.fuzzy-finder.telescope-nvim" },
  -- import/override with your plugins folder
  -- import/override with your plugins folder
}
