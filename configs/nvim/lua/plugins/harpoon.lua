---@type LazySpec
return {
  {
    "ThePrimeagen/harpoon",
    config = function()
      vim.keymap.set(
        "n",
        "<C-t>",
        function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end,
        { desc = "show harpoon quick menu" }
      )
      vim.keymap.set("n", "<leader>h", function() require("harpoon"):list():add() end, { desc = "add file" })
      vim.keymap.set(
        "n",
        "<leader>jf",
        function() require("harpoon"):list():select(1) end,
        { desc = "harpoon nav file 1" }
      )
      vim.keymap.set(
        "n",
        "<leader>jd",
        function() require("harpoon"):list():select(2) end,
        { desc = "harpoon nav file 2" }
      )
      vim.keymap.set(
        "n",
        "<leader>js",
        function() require("harpoon"):list():select(3) end,
        { desc = "harpoon nav file 3" }
      )
      vim.keymap.set(
        "n",
        "<leader>ja",
        function() require("harpoon"):list():select(4) end,
        { desc = "harpoon nav file 4" }
      )
    end,
  },
}
