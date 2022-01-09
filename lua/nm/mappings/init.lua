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

M.map('i', 'jj', '<Esc>')
-- M.map('i', '<Space>.', ' .')
M.map("n", "Q", "<nop>")
M.map("n", "<c-p>", "<cmd>lua require('nm.telescope').git_files()<cr>")
M.map("n", "<c-f>", "<cmd>lua require('telescope.builtin').live_grep{ cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1] }<cr>")
M.map("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>")
-- M.map("n", "<c-p>", "<cmd>lua require('telescope.builtin').git_files()<cr>")
-- M.map("n", "<Leader>b", "<cmd>lua require('telescope.builtin').buffers()<cr>")
-- M.map("n", "<c-p>", "<cmd>lua require('nm.telescope').find_files()<cr>")
-- M.map("n", "<c-p>", "<cmd>lua require('nm.telescope').find_files({ previewer = false })<cr>")
-- M.map("n", "<Leader>H", "<cmd>lua require('nm.telescope').help_tags()<cr>")
-- M.map("n", "<Leader>C", "<cmd>lua require('nm.telescope').colors()<cr>")
-- why am I using grep_string?
-- M.map("n", "<Leader>f", "<cmd>lua require('telescope.builtin').grep_string()<cr>")
-- M.map("n", "<Leader>f", "<cmd>lua require('telescope.builtin').live_grep()<cr>")
-- fix this so it goes into nvim config from anywhere
-- M.map("n", "<Leader>n", "<cmd>lua require('nm.telescope').nvim_files()<cr>")
--[[ npm i -g lua-fmt to use mapping
M.map("n", "<Leader>f", "<cmd>Format<cr>") ]]
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
-- Comment mappings
vim.api.nvim_set_keymap("n", "gcc", "<Plug>kommentary_line_default", {})
vim.api.nvim_set_keymap("n", "gc", "<Plug>kommentary_motion_default", {})
vim.api.nvim_set_keymap("v", "gcc", "<Plug>kommentary_visual_default", {})

-- Trouble (diagnostic handlings)
-- vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
--   {silent = true, noremap = true}
-- )
-- vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble lsp_workspace_diagnostics<cr>",
--   {silent = true, noremap = true}
-- )
-- vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble lsp_document_diagnostics<cr>",
--   {silent = true, noremap = true}
-- )
-- vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
--   {silent = true, noremap = true}
-- )
-- vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
--   {silent = true, noremap = true}
-- )
-- vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
--   {silent = true, noremap = true}
-- )
-- terminal M.mappings
M.map("t", "<Esc>", "<c-\\><c-n><esc><cr>")
--[[ M.map("t", "<Leader>,", "<c-\\><c-n>:bnext<cr>")
M.map("t", "<Leader>.", "<c-\\><c-n>:bprevious<cr>") ]]

--[[ M.map("n", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
M.map("n", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
M.map("n", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
M.map("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")

M.map("i", "<C-j>", "<cmd>TmuxNavigateDown<cr>")
M.map("i", "<C-k>", "<cmd>TmuxNavigateUp<cr>")
M.map("i", "<C-l>", "<cmd>TmuxNavigateRight<cr>")
M.map("i", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")

M.map("t", "<C-j>", "<c-\\><c-n>:TmuxNavigateDown<cr>")
M.map("t", "<C-k>", "<c-\\><c-n>:TmuxNavigateUp<cr>")
M.map("t", "<C-l>", "<c-\\><c-n>:TmuxNavigateRight<cr>")
M.map("t", "<C-h>", "<c-\\><c-n>:TmuxNavigateLeft<CR>")

M.map("n", "<Leader>tm", "<cmd>TableModeToggle<cr>") ]]

-- window navigation
M.map("n", "<C-j>", "<C-w>j")
M.map("n", "<C-k>", "<C-w>k")
M.map("n", "<C-l>", "<C-w>l")
M.map("n", "<C-h>", "<C-w>h")
M.map("t", "<C-j>", "<C-w>j")
M.map("t", "<C-k>", "<C-w>k")
M.map("t", "<C-l>", "<C-w>l")
M.map("t", "<C-h>", "<C-w>h")

--[[ M.map("i", "<Space>.", "<Nop>")
M.map("i", "<Space>,", "<Nop>") ]]

-- M.map("n", "<Leader>u", "<cmd>PackerUpdate<cr>")

-- for i = 1, 9 do
--   M.map("n", "<leader>" .. i, ':lua require"bufferline".go_to_buffer(' .. i .. ")<CR>")
--   M.map("t", "<leader>" .. i, '<C-\\><C-n>:lua require"bufferline".go_to_buffer(' .. i .. ")<CR>")
-- end

-- vim.cmd("cnoreabbrev x Sayonara")
-- vim.cmd("cnoreabbrev x BufDel")
-- vim.cmd("cnoreabbrev x! BufDel!")

-- tmap <C-j> <C-\><C-n>:TmuxNavigateDown<cr>
-- tmap <C-k> <C-\><C-n>:TmuxNavigateUp<cr>
-- tmap <C-l> <C-\><C-n>:TmuxNavigateRight<cr>
-- tmap <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
-- tmap <C-;> <C-\><C-n>:TmuxNavigatePrevious<cr>

--Move selected line/block of text in visual mode
M.map('x', 'K', ':move \'<-2<CR>gv-gv\'')
M.map('x', 'J', ':move \'>+1<CR>gv-gv\'')
return M
