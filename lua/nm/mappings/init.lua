local vim = vim
local api = vim.api
local M = {}
function M.map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
function M.mapBuf(buf, mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_buf_set_keymap(buf, mode, lhs, rhs, options)
end

-- this is the normal vim mapping but removing so it doesn't conflict with luasnip jumping. Use <c-m> instead (the other vim default for newline in insert mode)
-- M.map('i', '<C-j>', '<NL>')
M.map('i', 'jj', '<Esc>')
M.map("n", "Q", "<nop>")
M.map("n", "<c-p>", "<cmd>lua require('nm.telescope').git_files()<cr>")
M.map("n", "<c-f>", "<cmd>lua require('telescope.builtin').live_grep{ cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1] }<cr>")
M.map("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>")
-- M.map("n", "gr", "<cmd>lua require('trouble').lsp_references()<cr>")
-- three commands here. one opens window, other puts in on left side of screen, other sets the size of window setup file isn't working for that position... might be some setting i have set already, but defaulting to bottom without this
M.map("n", "gr", "<cmd>TroubleToggle lsp_references<cr><cmd>lua vim.cmd('wincmd H')<cr><cmd>vertical resize 55<cr>")
M.map("n", "gi", "<cmd>TroubleToggle lsp_implementations<cr><cmd>lua vim.cmd('wincmd H')<cr><cmd>vertical resize 55<cr>")
M.map("n", "gt", "<cmd>TroubleToggle lsp_type_definitions<cr><cmd>lua vim.cmd('wincmd H')<cr><cmd>vertical resize 55<cr>")
-- M.map("n", "gt", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<cr>")
M.map("n", "H", "^")
M.map("n", "L", "g_")
M.map("v", "H", "^")
M.map("v", "L", "g_")
M.map("n", "J", "5j")
M.map("n", "K", "5k")
M.map("v", "J", "5j")
M.map("v", "K", "5k")
M.map("v", "gJ", ":join<cr>")
M.map("n", ";", ":", {nowait = true, silent = false})
--M.map("n", "<Space>", "za")
--M.map("n", "<Space>", "za")
-- M.map("n", "<leader>tn", "<cmd>bnext<cr>")
-- M.map("n", "<leader>tp", "<cmd>bprevious<cr>")
-- M.map("n", "<leader>bd", ":BufDel<cr>")
M.map("n", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true})
M.map("n", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true})
M.map("v", "k", "v:count == 0 ? 'gk' : 'k'", {expr = true})
M.map("v", "j", "v:count == 0 ? 'gj' : 'j'", {expr = true})
M.map("v", "<", "<gv")
M.map("v", ">", ">gv")
-- What does this do?
-- M.map("n", "<Leader>d", '"_d')
-- M.map("v", "<Leader>d", '"_d')
M.map("n", "<Esc>", "<cmd>noh<cr>")
-- TODO: see if we can remap the visual multi commands otherwise might not use plugin
--[[ vim.cmd("let g:VM_maps['Find Under'] = '<Leader>vm'")
vim.cmd("let g:VM_maps['Find Under'] = '<Leader>vm'") ]]

-- terminal M.mappings
M.map("t", "<Esc>", "<c-\\><c-n><esc><cr>")

-- window navigation
M.map("n", "<C-j>", "<C-w>j")
M.map("n", "<C-k>", "<C-w>k")
M.map("n", "<C-l>", "<C-w>l")
M.map("n", "<C-h>", "<C-w>h")
M.map("t", "<C-j>", "<C-w>j")
M.map("t", "<C-k>", "<C-w>k")
M.map("t", "<C-l>", "<C-w>l")
M.map("t", "<C-h>", "<C-w>h")

-- window resizing
M.map("n", "<S-Right>", "<C-w>>")
M.map("n", "<S-Left>", "<C-w><")
M.map("n", "<S-Up>", "<C-w>+")
M.map("n", "<S-Down>", "<C-w>-")

--Move selected line/block of text in visual mode
-- M.map('x', 'K', ':move \'<-2<CR>gv-gv\'')
-- M.map('x', 'J', ':move \'>+1<CR>gv-gv\'')
return M
