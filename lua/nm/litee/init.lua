-- revisit this a later day when they've made more improvements
-- configure the litee.nvim library
require("litee.lib").setup({
	tree = {
		icon_set = "codicons",
	},
	panel = {
		orientation = "left",
		panel_size = 30,
	},
})

-- configure litee-filetree.nvim
require("litee.filetree").setup({})

require("litee.calltree").setup({})
require("litee.symboltree").setup({})
