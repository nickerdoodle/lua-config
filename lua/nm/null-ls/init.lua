local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local M = {}

function M.setup(opts)
  null_ls.setup({
    debug = true,
    on_attach = opts.on_attach,
    sources = {
      formatting.stylua,
      -- install globally to use: npm i -g eslint_d
      -- use eslint_d because it's MUCH faster and actually works when calling vim.lsp.buf.formatting_sync()
      -- must use prettier before eslint_d because it is conflicting with eslint_d. try to find where the config file is and change it so not in conflict... it is defaulting to double quotes for js strings. Not following .eslintrc.json
      formatting.prettier,
      -- formatting.eslint_d,
      -- eslint_d diagnostics is also much faster
      diagnostics.eslint_d,
      null_ls.builtins.code_actions.eslint_d,

      -- doesn't work
      -- formatting.eslint,

      -- diagnostics.eslint,
      -- diagnostics.flake8.with({ filetypes = { "python" } }),
      -- diagnostics.shellcheck.with({ extra_args = { "--severity", "warning" } }),
      -- diagnostics.codespell.with({ filetypes = { "javascript", "python" } }),
    },
  })
end

return M
