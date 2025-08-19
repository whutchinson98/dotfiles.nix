local capabilities = require('cmp_nvim_lsp').default_capabilities()

return {
	cmd = { 'rnix-lsp' },
	filetypes = { 'nix' },
  setup = {
    capabilities = capabilities
  }
}
