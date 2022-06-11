local M = {
  base00 = "#1b2b34",
  base01 = "#343d46",
  base02 = "#4f5b66",
  base03 = "#65737e",
  base04 = "#a7adba",
  base05 = "#c0c5ce",
  base06 = "#cdd3de",
  base07 = "#d8dee9",
  red = "#ec5f67",
  orange = "#f99157",
  yellow = "#fac863",
  green = "#99c794",
  cyan = "#62b3b2",
  blue = "#6699cc",
  purple = "#c594c5",
  brown = "#ab7967",
  white = "#ffffff"
}

-- vim.cmd("colorscheme OceanicNext")
-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }


-- Load the colorscheme
-- vim.cmd[[colorscheme tokyonight]]
--
vim.g.vscode_style = "dark"
vim.g.vscode_transparent = 1
-- Enable italic comment
vim.g.vscode_italic_comment = 1
vim.cmd[[colorscheme vscode]]


function M.setItalics()
  vim.cmd("hi Comment gui=italic")
  vim.cmd("hi Keyword gui=italic")
  vim.cmd("hi Keyword gui=italic")
  vim.cmd("hi Identifier gui=italic")
  vim.cmd("hi StorageClass gui=italic")
  vim.cmd("hi jsLineComment gui=italic")
  vim.cmd("hi xmlAttrib gui=italic")
  vim.cmd("hi htmlArg gui=italic")
  vim.cmd("hi pythonSelf gui=italic")
end

vim.cmd([[ highlight Normal guibg=#000000]])


-- diffview highlights
vim.cmd("highlight DiffAdd gui=NONE guibg=#274259")
vim.cmd("highlight DiffDelete gui=NONE guibg=#392030")
--

return M
