---@type LazySpec
return {
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>vs", function() vim.cmd ":Git" end, { desc = "add file" })
      -- keymap("n", "<leader>vs", ":Git <CR>", opts)
    end,
  },
}
