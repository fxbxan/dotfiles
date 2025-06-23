-- Lazy should load first! --
require("config.lazy")
require("config.keymappings")
require("config.options")


local lspconfig = require('lspconfig')

lspconfig.ts_ls.setup {}
lspconfig.volar.setup {}
