---@type LazySpec
-- return {
--     "neovim/nvim-lspconfig",
--     config = function()
--       vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, {desc = "lsp format"})
--     end
-- }
return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format, {desc = "lsp format"})
      -- Set up lspconfig with cmp capabilities
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
      -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
      --   capabilities = capabilities
      -- }
    end,
  },
}
