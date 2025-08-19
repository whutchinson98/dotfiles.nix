return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
        show_hidden_count = true,
        hide_dotfiles = false,
        hide_gitignored = false,  -- Try setting this to false too
        hide_by_name = {
          ".git",
          ".DS_Store",
          "thumbs.db",
        },
        never_show = {},
      },
    },
  },
  lazy = false,
  config = function()
    vim.keymap.set(
      "n",
      "<leader>o",
      ':Neotree toggle<CR>',
      { desc = "toggle neotree" }
    )
  end,
}
