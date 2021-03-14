local map = require('nm.mappings').map
local M = {}
map("n", "<C-b>", "<cmd>lua require('nvim-tree').toggle()<cr>")
return M
