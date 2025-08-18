require("config.lazy")

-- TODO: programmatically build lsps
vim.lsp.enable("luals")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("nix")

require("options")
require("config.keys")
require("config.colorsheme")
