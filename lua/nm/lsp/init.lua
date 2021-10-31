local vim = vim
local uv = vim.loop
local lspconfig = require('lspconfig')
local configs = require('lspconfig/configs')
local mapBuf = require('nm.mappings').mapBuf
-- local autocmd = require('nm.autocmds').autocmd
-- local npairs = require('nvim-autopairs')
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
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
    -- decided to turn this to false, it's too crowded with warnings/errors
    virtual_text = false,
    underline = true
  })

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

  client.resolved_capabilities.document_formatting = true

  -- set up signature help
  require "lsp_signature".on_attach({
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    handler_opts = {
      border = "single"
    }
  }, bufnr)

-- cmp stuff
  local cmp = require('cmp')

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
      --TODO: add preselect

      ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 's' }),
      -- TODO: add something so that tabbing through a snippet does not use lsp suggestions
      -- handle tab mapping
      ['<Tab>'] = function(fallback)
        -- if autocomplete menu is visible
        if cmp.visible() then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, true, true), 'i')
        elseif vim.fn['vsnip#available']() == 1 then
          vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
        else
          fallback()
        end
      end,
      -- ['<Tab>'] = function(fallback)
      --   if vim.fn['vsnip#available']() == 1 then
      --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
      --   -- if autocomplete menu is visible
      --   elseif cmp.visible() then
      --     -- with the conditional this mapping doesn't work for tab... not sure why
      --     -- cmp.mapping.confirm({
      --     --     behavior = cmp.ConfirmBehavior.Insert,
      --     --     select = true,
      --     -- })
      --     -- Workaround. Use behavior of enter key which currently will autocomplete the word
      --     vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<CR>', true, true, true), 'i')
      --   else
      --     fallback()
      --   end
      -- end,
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
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

    experimental = {
      -- using the newer menu
      native_menu = false,

      -- when typing, the word will show the completion as virtual text
      ghost_text = true,

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
      { name = 'buffer', keyword_length = 5 },
      { name = 'calc' },
      { name = 'spell', keyword_length = 5 },
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

-- TODO: run :LspInstallInfo and set up the other language servers

local lsp_installer = require "nvim-lsp-installer"

-- code to allow eslint to format document
-- TODO: in js files, have eslint format by default. server is asking between eslint and tsserver

lsp_installer.on_server_ready(function (server)
    local opts = {
        on_attach = on_attach,
        format = { enable = true }, -- this will enable formatting
        capabilities = capabilities
    }

    if server.name == "eslint" then
        opts.on_attach = function (client, bufnr)
            -- neovim's LSP client does not currently support dynamic capabilities registration, so we need to set
            -- the resolved capabilities of the eslint server ourselves!
            client.resolved_capabilities.document_formatting = true
            on_attach(client, bufnr)
            -- common_on_attach(client, bufnr)
        end
        opts.settings = {
            format = { enable = true }, -- this will enable formatting
        }
    end

    if server.name == "tsserver" then
        opts.on_attach = function (client, bufnr)
            -- neovim's LSP client does not currently support dynamic capabilities registration, so we need to set
            -- the resolved capabilities of the eslint server ourselves!
            -- we want to use eslint instead of tsserver for formatting
            client.resolved_capabilities.document_formatting = false
            on_attach(client, bufnr)
        end

        opts.settings = {
            format = { enable = false }, -- this will enable formatting
        }
    end

    server:setup(opts)
end)
--

return M
