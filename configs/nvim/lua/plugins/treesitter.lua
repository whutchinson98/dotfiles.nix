---@type LazySpec
return {
  "nvim-treesitter/nvim-treesitter",
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "rust",
      "typescript",
      -- add more arguments for adding more treesitter parsers
    },
  },
}
