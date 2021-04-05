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
--compe stuff
vim.g.completion_enable_auto_paren = 1
-- vim.g.completion_confirm_key = "\<CR>"
-- vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}

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
    -- the snips fields listed are just custom snippet plugins. Not necessary
    -- but compe is able to provide autocomplete for them as well
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
local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end
-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
    -- figure out vsnips before putting this back in. it's making tab do things I don't understand for now
   elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
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

--
vim.g.completion_confirm_key = ""
_G.completion_confirm=function()
  if vim.fn.pumvisible() ~= 0  then
    if vim.fn.complete_info()["selected"] ~= -1 then
      vim.fn["compe#confirm"]()
      return npairs.esc("<c-y>")
    else
      vim.defer_fn(function()
        vim.fn["compe#confirm"]("<cr>")
      end, 20)
      return npairs.esc("<c-n>")
    end
  else
    return npairs.check_break_line_char()
  end
end
vim.api.nvim_set_keymap("i" , "<CR>","v:lua.completion_confirm()", {expr = true})
--

vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
--

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
  vim.cmd('nnoremap <silent> <C-[> :Lspsaga diagnostic_jump_prev<CR>')
vim.cmd('nnoremap <silent> <C-n> :Lspsaga diagnostic_jump_next<CR>')
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

  -- completion.on_attach(client)
end
local servers = {"pyls", "bashls"}
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities
  }
end

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
                            -- "/.config/nvim/ls/lua-language-server"
                            "/.config/nvim/lua-language-server"
    sumneko_binary = "/Users/" .. USER ..
                         -- "/.config/nvim/ls/lua-language-server/bin/macOS/lua-language-server"
                         "/.config/nvim/lua-language-server/bin/macOS/lua-language-server"
elseif vim.fn.has("unix") == 1 then
    sumneko_root_path = "/home/" .. USER ..
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
return M
