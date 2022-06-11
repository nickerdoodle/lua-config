-- color highlights set in colors/init.lua
vim.cmd("set fillchars+=diff:╱")

require("diffview").setup({
	enhanced_diff_hl = true,
})
