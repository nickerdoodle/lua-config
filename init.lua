-- init.lua
-- if vim.g.vscode then
--   -- vscode is reading in extensions and mappings but commenting the extensions out or if block isn't making a difference. all plugins load. Could be a packer issue
-- 	-- VSCode extension
-- 	-- vim.cmd([[source XXXXX.vim]])
-- 	require("nm/options")
-- 	require("nm/mappings")
-- else
	-- ordinary neovim
	vim.cmd("filetype plugin indent on")
	-- need impatient before other plugins to cache them to improve startup
	require("impatient")
	-- TODO: put filetype in its own file
	require("filetype").setup({})

	require("nm/plugins")
	require("nm/options")
	require("nm/mappings")
	require("nm/util")
	require("nm/telescope")
	-- TODO: may not need autopairs anymore
	require("nm/nvim-autopairs")
	require("nm/colors")
	require("nm/dressing")
	require("nm/autocmds")
	require("nm/nvim-gps")
	require("nm/galaxyline")
	require("nm/treesitter")
	require("nm/null-ls")
	require("nm/luasnip")
	require("nm/lsp")
	require("nm/lspkind")
	require("nm/nvim-tree")
	require("nm/neogit")
	require("nm/vgit")
	require("nm/bufferline")
  require("nm/which-key")
	require("nm/autopairs")
	require("nm/toggleterm")
	require("nm/dap-install")
	require("nm/dap-ui")
	require("nm/jester")
	require("nm/indent-blankline")
	require("nm/neoclip")
	require("nm/trouble")

	-- require "nm/litee"

	-- require "nm/formatting"
	-- require "nm/lightbulb"

	-- TODO: remove
	-- require "nm/statusline"
-- end
