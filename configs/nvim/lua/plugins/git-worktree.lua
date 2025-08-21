---@type LazySpec
return {
  "whutchinson98/git-worktree.nvim",
  -- version = "^2",
  dependencies = { "nvim-lua/plenary.nvim" },
  enabled = true,
  config = function()
    require("telescope").load_extension "git_worktree"
    vim.keymap.set(
      "n",
      "<leader>pw",
      function() require("telescope").extensions.git_worktree.git_worktree() end,
      { desc = "Worktrees" }
    )
    vim.keymap.set(
      "n",
      "<leader>pc",
      function() require("telescope").extensions.git_worktree.create_git_worktree() end,
      { desc = "Create Worktree" }
    )
  end,
}
