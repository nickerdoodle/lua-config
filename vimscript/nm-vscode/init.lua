-- reference https://github.com/Axlefublr/dotfiles/blob/main/init.lua
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.termguicolors = true
vim.g.mapleader = " "

require("packer").startup(function(use)
  use "wbthomason/packer.nvim"
  -- I did have to run PackerSync in Vscode for this to install and work. Reload vscode after
  use({
    "kylechui/nvim-surround",
    tag = "*",
    config = function()
      require("nvim-surround").setup()
    end
  })
end)

-- insert mode keymaps don't work in vscode. Need to set them in vscode
-- vim.keymap.set("i", "jj", "<Esc>", {})
vim.keymap.set("n", "J", "5j", {})
vim.keymap.set("n", "K", "5k", {})
vim.keymap.set("v", "J", "5j", {})
vim.keymap.set("v", "K", "5k", {})
vim.keymap.set("n", "L", "g_", {})
vim.keymap.set("n", "H", "^", {})
vim.keymap.set("n", "gJ", ":join<CR>", {})
vim.keymap.set("v", "<", "<gv", {})
vim.keymap.set("v", ">", ">gv", {})
vim.keymap.set("v", "K", "<-2<CR>gv-gv", {})
vim.keymap.set("v", "J", "<+1<CR>gv-gv", {})
vim.keymap.set("n", "gl", function() vim.fn.VSCodeNotify("editor.action.openLink") end)
vim.keymap.set("n", "gd", function() vim.fn.VSCodeNotify("editor.action.revealDefinition") end)
vim.keymap.set("n", "gD", function() vim.fn.VSCodeNotify("editor.action.goToDeclaration") end)
vim.keymap.set("n", "<C-w>gd", function() vim.fn.VSCodeNotify("editor.action.revealDefinitionAside") end)
vim.keymap.set("n", "gi", function() vim.fn.VSCodeNotify("editor.action.goToImplementation") end)
vim.keymap.set("n", "gr", function() vim.fn.VSCodeNotify("references-view.findReferences") end)
vim.keymap.set("n", "gh", function() vim.fn.VSCodeNotify("editor.action.showHover") end)
vim.keymap.set("n", "<leader>k", function() vim.fn.VSCodeNotify("editor.action.showDefinitionPreviewHover") end)
vim.keymap.set("n", "<leader>ca", function() vim.fn.VSCodeNotify("editor.action.quickFix") end)

vim.keymap.set("n", "<leader>tn", function() vim.fn.VSCodeNotify("workbench.action.terminal.newInActiveWorkspace") end)
vim.keymap.set("n", "<leader>tk", function() vim.fn.VSCodeNotify("workbench.action.terminal.kill") end)

vim.keymap.set("n", "<leader>tc",
  function() vim.cmd("norm viw") vim.fn.VSCodeNotifyVisual("turboConsoleLog.displayLogMessage", true) vim.cmd("norm <Esc>") end)
vim.keymap.set("v", "<leader>tc", function() vim.fn.VSCodeNotifyVisual("turboConsoleLog.displayLogMessage", true) end)

vim.keymap.set("n", "?",
  function() vim.cmd("norm viw") vim.fn.VSCodeNotifyVisual("workbench.action.findInFiles", true) end)
vim.keymap.set("n", "<leader><leader>f",
  function() vim.cmd("norm viw") vim.fn.VSCodeNotifyVisual("workbench.action.findInFiles", true) end)
vim.keymap.set("v", "<leader><leader>f", function() vim.fn.VSCodeNotifyVisual("workbench.action.findInFiles", true) end)
vim.keymap.set("v", "<leader><leader>r",
  function() vim.fn.VSCodeNotifyVisual("workbench.action.replaceInFiles", true) end)

vim.keymap.set("v", "<leader><leader>C",
  function() vim.fn.VSCodeNotifyVisual("editor.action.clipboardCopyAction", true) end)

-- when true, the comment is block comment. When false, comment is line comment
vim.keymap.set("n", "gcc", function() vim.fn.VSCodeNotify("editor.action.commentLine", false) end)
vim.keymap.set("v", "gc", function() vim.fn.VSCodeNotifyVisual("editor.action.commentLine", false) end)

vim.keymap.set("n", "zp", function() vim.fn.VSCodeNotify("editor.gotoParentFold", true) end)
vim.keymap.set("n", "zf", function() vim.fn.VSCodeNotify("editor.toggleFold", true) end)
vim.keymap.set("n", "za", function() vim.fn.VSCodeNotify("editor.foldAll", true) end)

vim.keymap.set("n", "<C-j>", function() vim.fn.VSCodeNotify("workbench.action.navigateDown") end)
vim.keymap.set("n", "<C-k>", function() vim.fn.VSCodeNotify("workbench.action.navigateUp") end)
vim.keymap.set("n", "<C-l>", function() vim.fn.VSCodeNotify("workbench.action.navigateRight") end)
vim.keymap.set("n", "<C-h>", function() vim.fn.VSCodeNotify("workbench.action.navigateLeft") end)

-- do not use these insert mode keymaps in vscode. They will make the cursor jump panes when using jj as esc
-- vim.keymap.set("i", "<C-j>", function() vim.fn.VSCodeNotify("workbench.action.navigateDown") end)
-- vim.keymap.set("i", "<C-k>", function() vim.fn.VSCodeNotify("workbench.action.navigateUp") end)
-- vim.keymap.set("i", "<C-l>", function() vim.fn.VSCodeNotify("workbench.action.navigateRight") end)
-- vim.keymap.set("i", "<C-h>", function() vim.fn.VSCodeNotify("workbench.action.navigateLeft") end)
vim.keymap.set("", ";", ":")

vim.keymap.set("v", "s", "<Plug>VSurround")
