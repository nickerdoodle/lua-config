local vim = vim
local uv = vim.loop
local lspconfig = require('lspconfig')
local mapBuf = require('nm.mappings').mapBuf
local autocmd = require('nm.autocmds').autocmd
local npairs = require('nvim-autopairs')
-- local completion = require('completion')
-- require('snippets').use_suggested_mappings()

vim.cmd [[set shortmess+=c]]
vim.o.completeopt = "menuone,noselect"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true

local M = {}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
--TODO: figure out if I want the virtual text or not for diagnostics.
--Either way, also figure out how to disable lspsaga or the built in diagnostics
--because they are both showing up and overlapping.
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {virtual_text = true})

local function completionItemResolveCB(err, _, result)
  if err or not result then
    return
  end
  local bufnr = vim.api.nvim_get_current_buf()
  if result.additionalTextEdits then
    vim.lsp.util.apply_text_edits(result.additionalTextEdits, bufnr)
  end
end
local function requestCompletionItemResolve(bufnr, item)
  vim.lsp.buf_request(bufnr, "completionItem/resolve", item, completionItemResolveCB)
end
function M.on_complete_done()
  local bufnr = vim.api.nvim_get_current_buf()
  local completed_item_var = vim.v.completed_item
  if
    completed_item_var and completed_item_var.user_data and completed_item_var.user_data.nvim and
      completed_item_var.user_data.nvim.lsp and
      completed_item_var.user_data.nvim.lsp.completion_item
   then
    local item = completed_item_var.user_data.nvim.lsp.completion_item
    requestCompletionItemResolve(bufnr, item)
  end
  if
    completed_item_var and completed_item_var.user_data and completed_item_var.user_data and
      completed_item_var.user_data.lsp and
      completed_item_var.user_data.lsp.completion_item
   then
    local item = completed_item_var.user_data.lsp.completion_item
    requestCompletionItemResolve(bufnr, item)
  end
end

local function get_node_modules(root_dir)
  -- util.find_node_modules_ancestor()
  local root_node = root_dir .. "/node_modules"
  local stats = uv.fs_stat(root_node)
  if stats == nil then
    return nil
  else
    return root_node
  end
end
local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
    title = ""
  }
  vim.lsp.buf.execute_command(params)
end

local default_node_modules = get_node_modules(vim.fn.getcwd())

local on_attach = function(client, bufnr)
  print("LSP started.");
  -- need to install these first probably
	-- require'diagnostic'.on_attach(client)
--
-- cmp stuff

  local cmp = require('cmp')
  local lspkind = require('lspkind')

  local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s')
  end

  cmp.setup {
    -- set snippet engine (vsnip)
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
      end,
    },
    -- You can set mappings if you want
    mapping = {
      ['<C-p>'] = cmp.mapping.select_prev_item(),
      ['<C-n>'] = cmp.mapping.select_next_item(),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<Esc>'] = cmp.mapping.abort(),
      -- ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 's' }),
      ['<Tab>'] = function(fallback)
        if vim.fn.pumvisible() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<C-n>', true, true, true), 'n')
        elseif check_back_space() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Tab>', true, true, true), 'n')
        elseif vim.fn['vsnip#available']() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
        else
          fallback()
        end
      end,
      ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      })
    },
    formatting = {
      format = function(entry, vim_item)
        -- fancy icons and a name of kind
        vim_item.kind = require("lspkind").presets.default[vim_item.kind]
          .. " "
          .. vim_item.kind
        -- set a name for each source
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          vsnip = "[Vsnip]",
          buffer = "[Buffer]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          latex_symbols = "[Latex]"
        })[entry.source.name]
        return vim_item
      end,
    },

    -- You should specify your *installed* sources.
    -- The order of the sources will determine the order they display on the popup menu
    sources = {
      { name = 'nvim_lsp' },
      { name = 'vsnip' },
      { name = 'snippets_nvim' },
      { name = 'nvim_lua' },
      { name = 'path' },
      { name = 'treesitter' },
      { name = 'buffer' },
      { name = 'calc' },
      { name = 'spell' },
      { name = 'tags' },
    },
  }
-- end cmp
--compe stuff
vim.g.completion_enable_auto_paren = 1
-- vim.g.completion_confirm_key = "\<CR>"
-- vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}

-- list of available options
-- buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--   buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--   buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--   buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--   buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--   buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--   buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--   buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--   buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--   buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--   buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--   buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--   buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
--   buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
--   buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
--   buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
--   buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
-- TODO: some of these commands don't work with mapBuf. needed to use vim.cmd instead. Find out why and try to get them to use the map if possible
  mapBuf(bufnr, "n", "<silent> gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
  -- mapBuf(bufnr, "n", "<Leader>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
  mapBuf(bufnr, "n", "<silent> gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")

  --Hover
  -- mapBuf(bufnr, "n", "<Leader>gh", "<Cmd>lua vim.lsp.buf.hovnr()<CR>")
  mapBuf(bufnr, "n", "<Leader>gh", "<CMD>lua require('lspsaga.hover').render_hover_doc()<cr>")
  -- vim.cmd('nnoremap <Leader>gh :Lspsaga hover_doc<CR>')
  --[[ mapBuf(bufnr, "n", "<silent> <C-[>", "<cmd>lua require('lspsaga.diagnostic_jump_prev()<CR>")
  mapBuf(bufnr, "n", "<silent> <C-n>", "<cmd>lua require('lspsaga.diagnostic_jump_next()<CR>") ]]
  --[[ vim.cmd('nnoremap <silent> <C-[> :Lspsaga diagnostic_jump_prev<CR>')
vim.cmd('nnoremap <silent> <C-n> :Lspsaga diagnostic_jump_next<CR>') ]]
  -- mapBuf(bufnr, "n", "<Leader>gh", "<CMD>lua require('lspsaga.hover').render_hover_doc()<cr>")
  -- mapBuf(bufnr, "n", "<Leader>gah", "<CMD>lua require('lspsaga.provider').lsp_finder()<cr>")

  mapBuf(bufnr, "n", "<silent> gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  mapBuf(bufnr, "n", "<silent> gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  mapBuf(bufnr, "n", "<silent> gtd", "<cmd>lua vim.lsp.buf.type_definition()<CR>")

  -- rename
  -- mapBuf(bufnr, "n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  mapBuf(bufnr, "n", "<Leader>r", "<cmd>lua require('lspsaga.rename').rename()<cr>")

  -- mapBuf(bufnr, "n", "<Leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  mapBuf(bufnr, "n", "<silent>gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  vim.cmd('nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>')

  -- mapBuf(bufnr, "n", "<C-.>", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  -- mapBuf(bufnr, "n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  -- mapBuf(bufnr, "v", "<Leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>")
  mapBuf(bufnr, "n", "<Leader>ca", "<cmd>lua require('lspsaga.codeaction').code_action()<cr>")
  mapBuf(bufnr, "v", "<Leader>ca", "<cmd>lua require('lspsaga.codeaction').range_code_action()<cr>")

  -- I don't want the diagnostic hover to show up
  -- autocmd("CursorHold", "<buffer>", "lua vim.lsp.diagnostic.show_line_diagnostics()")
  -- autocmd("CursorHold", "<buffer>", "lua require'lspsaga.diagnostic'.show_line_diagnostics()")


  -- if client.name ~= "angularls" then
  --   autocmd("CompleteDone", "<buffer>", "lua require('nm.lsp').on_complete_done()")
  -- end
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
  --[[ vim.fn.sign_define("LspDiagnosticsSignError", {text = "•"})
  vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "•"})
  vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "•"})
  vim.fn.sign_define("LspDiagnosticsSignHint", {text = "•"}) ]]
  vim.fn.sign_define("LspDiagnosticsSignError", {text = ""})
  vim.fn.sign_define("LspDiagnosticsSignWarning", {text = ""})
  vim.fn.sign_define("LspDiagnosticsSignInformation", {text = ""})
  vim.fn.sign_define("LspDiagnosticsSignHint", {text = ""})
  vim.fn.sign_define("LspDiagnosticsSignOther", {text = "﫠"})

  -- completion.on_attach(client)
end

-- local servers = {"pyls", "bashls"}
local servers = {"bashls"}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

--[[ lspconfig.pyls.setup {
    on_attach = on_attach,
    capabilities = capabilities
}

lspconfig.bashls.setup {
    on_attach = on_attach,
    capabilities = capabilities
} ]]

local ngls_cmd = {
  "ngserver",
  "--stdio",
  "--tsProbeLocations",
  default_node_modules,
  "--ngProbeLocations",
  default_node_modules,
  "--experimental-ivy"
}

lspconfig.angularls.setup {
  cmd = ngls_cmd,
  on_attach = on_attach,
  -- trying this. Need something to override tsserver
  -- filetypes = { "typescript", "html", "typescriptreact", "typescript.tsx" },
  -- root_dir = root_pattern("angular.json", ".git"),
  capabilities = capabilities,
  on_new_config = function(new_config)
    new_config.cmd = ngls_cmd
  end
}

lspconfig.tsserver.setup {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue"
  },
  on_attach = on_attach,
  capabilities = capabilities,
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports"
    }
  }
}

local vs_code_extracted = {
  html = "html-languageserver",
  cssls = "css-languageserver",
  jsonls = "vscode-json-languageserver",
  vimls = "vim-language-server"
}

for ls, cmd in pairs(vs_code_extracted) do
  lspconfig[ls].setup {
    cmd = {cmd, "--stdio"},
    on_attach = on_attach,
    capabilities = capabilities
  }
end

USER = vim.fn.expand('$USER')

local sumneko_root_path = ""
local sumneko_binary = ""

if vim.fn.has("mac") == 1 then
    sumneko_root_path = "/Users/" .. USER ..
                            "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server"
    sumneko_binary = "/Users/" .. USER ..
                         "/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin/macOS/lua-language-server"
elseif vim.fn.has("unix") == 1 then
    sumneko_root_path = "/home/" .. USER ..
      -- TODO: adjust this path for linux after now using lspinstaller plugin instead of manually installing
                            -- "/.config/nvim/ls/lua-language-server"
                            "/.config/nvim/lua-language-server"
    sumneko_binary = "/home/" .. USER ..
                         -- "/.config/nvim/ls/lua-language-server/bin/Linux/lua-language-server"
                         "/.config/nvim/lua-language-server/bin/Linux/lua-language-server"
else
    print("Unsupported system for sumneko")
end

lspconfig.sumneko_lua.setup {
    filetypes = {"lua"},
    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                version = 'LuaJIT',
                -- Setup your lua path
                path = vim.split(package.path, ';')
            },
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {'vim'}
            },
            workspace = {
                -- Make the server aware of Neovim runtime files
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            }
        }
    }
}

-- TODO: run :LspInstallInfo and set up the other language servers
local pid = vim.fn.getpid()
-- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
-- Needs to be full path
-- check installation docs for a command to be run for mac
-- installed with lspinstaller plugin
local omnisharp_bin = "/Users/nicholasmahe/.local/share/nvim/lsp_servers/omnisharp/omnisharp/run"
-- on Windows
-- local omnisharp_bin = "/path/to/omnisharp/OmniSharp.exe"
require'lspconfig'.omnisharp.setup{
    cmd = { omnisharp_bin, "--languageserver" , "--hostPID", tostring(pid) },
    capabilities = capabilities,
    on_attach = on_attach,
    -- defaults
    --[[ filetypes = { "cs", "vb" };
    init_options = {};
    on_new_config = function(new_config, new_root_dir)
          if new_root_dir then
            table.insert(new_config.cmd, '-s')
            table.insert(new_config.cmd, new_root_dir)
          end
        end,
    root_dir = root_pattern(".sln") or root_pattern(".csproj") ]]
}
return M
