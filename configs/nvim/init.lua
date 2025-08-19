require("config.lazy")

-- TODO: programmatically build lsps
vim.lsp.enable({"lua_ls", "rust_analyzer", "nix"})

require("options")
require("config.keys")
require("config.colorsheme")
