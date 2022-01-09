local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    debug = true,
    sources = {
        formatting.stylua,
        -- is formatting.eslint a thing? Or do I just use the diagnostics?
        -- formatting.eslint,
        formatting.prettier,
        diagnostics.eslint,
    },
})
