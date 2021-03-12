local vim = vim
local uv = vim.loop
local lspconfig = require('lspconfig')
local mapBuf = require('nm.mappings').mapBuf
local autocmd = require('nm.autocmds').autocmd
require('snippets').use_suggested_mappings()

-- vim.o.completeopt = "menuone,noselect"
-- require('compe').setup({
--   enabled = true;
--   autocomplete = true;
--   debug = false;
--   min_length = 1;
--   preselect = 'enable';
--   throttle_time = 80;
--   source_timeout = 200;
--   incomplete_delay = 400;
--   max_abbr_width = 100;
--   max_kind_width = 100;
--   max_menu_width = 100;
--
--   source = {
--     path = true;
--     buffer = true;
--     calc = true;
--     vsnip = true;
--     nvim_lsp = true;
--     nvim_lua = true;
--     spell = true;
--     tags = true;
--     snippets_nvim = true;
--     treesitter = true;
--   };
-- })

vim.cmd [[set shortmess+=c]]
vim.o.completeopt = "menuone,noselect"

require('compe').setup ({
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  allow_prefix_unmatch = false;
  max_abbr_width = 1000;
  max_kind_width = 1000;
  max_menu_width = 1000000;
  documentation = true;

  source = {
    path = true;
    buffer = true;
    calc = true;
    -- do i need to install vsnip or snippets_nvim?
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
    treesitter = true;
  };
})

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end

vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local M = {}

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {virtual_text = false})

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
  -- completion.on_attach()
  --  might try using another one besides completion
  require'completion'.on_attach(client)
  -- I added this
  print("LSP started.");
  -- need to install these first probably
	-- require'completion'.on_attach(client)
	-- require'diagnostic'.on_attach(client)
--

  mapBuf(bufnr, "n", "<Leader>gdc", "<Cmd>lua vim.lsp.buf.declaration()<CR>")
  -- mapBuf(bufnr, "n", "<Leader>gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")
  mapBuf(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>")

  --Hover
  mapBuf(bufnr, "n", "<Leader>gh", "<Cmd>lua vim.lsp.buf.hovnr()<CR>")
  -- mapBuf(bufnr, "n", "<Leader>gh", "<CMD>lua require('lspsaga.hover').render_hover_doc()<cr>")

  mapBuf(bufnr, "n", "<Leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  mapBuf(bufnr, "n", "<Leader>gs", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  mapBuf(bufnr, "n", "<Leader>gtd", "<cmd>lua vim.lsp.buf.type_definition()<CR>")

  -- rename
  mapBuf(bufnr, "n", "<Leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  -- mapBuf(bufnr, "n", "<Leader>rn", "<cmd>lua require('lspsaga.rename').rename()<cr>")

  -- mapBuf(bufnr, "n", "<Leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>")
  mapBuf(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")

  -- mapBuf(bufnr, "n", "<C-<Space>>", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  mapBuf(bufnr, "n", "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  mapBuf(bufnr, "v", "<Leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>")
  -- mapBuf(bufnr, "n", "<Leader>ca", "<cmd>lua require('lspsaga.codeaction').code_action()<cr>")
  -- mapBuf(bufnr, "v", "<Leader>ca", "<cmd>lua require('lspsaga.codeaction').range_code_action()<cr>")

  autocmd("CursorHold", "<buffer>", "lua vim.lsp.diagnostic.show_line_diagnostics()")
  -- autocmd("CursorHold", "<buffer>", "lua require'lspsaga.diagnostic'.show_line_diagnostics()")


  -- if client.name ~= "angularls" then
  --   autocmd("CompleteDone", "<buffer>", "lua require('nm.lsp').on_complete_done()")
  -- end
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
  vim.fn.sign_define("LspDiagnosticsSignError", {text = "•"})
  vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "•"})
  vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "•"})
  vim.fn.sign_define("LspDiagnosticsSignHint", {text = "•"})
end
local servers = {"pyls", "bashls"}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

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

-- can't get this to work so just doing individually
for ls, cmd in pairs(vs_code_extracted) do
  lspconfig[ls].setup {
    cmd = {cmd, "--stdio"},
    on_attach = on_attach,
    capabilities = capabilities
  }
end

-- TODO: will need to change this. Look at lsp docs
-- go to lsp-config md and follow instructions to install lua server
-- local lua_lsp_loc = "/Users/mhartington/Github/lua-language-server"

local ngls_cmd = {
  "ngserver",
  "--stdio",
  "--tsProbeLocations",
  default_node_modules,
  "--ngProbeLocations",
  "--experimental-ivy"
}

lspconfig.angularls.setup {
  cmd = ngls_cmd,
  on_attach = on_attach,
  capabilities = capabilities,
  on_new_config = function(new_config)
    new_config.cmd = ngls_cmd
  end
}

lspconfig.sumneko_lua.setup {
  -- cmd = {lua_lsp_loc .. "/bin/macOS/lua-language-server", "-E", lua_lsp_loc .. "/main.lua"},
  capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    Lua = {
      runtime = {version = "LuaJIT", path = vim.split(package.path, ";")},
      diagnostics = {globals = {"vim"}},
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true
        }
      }
    }
  }
}
return M
