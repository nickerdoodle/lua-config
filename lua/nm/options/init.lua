-- Options
local Type = { GLOBAL_OPTION = "o", WINDOW_OPTION = "wo", BUFFER_OPTION = "bo" }
local add_options = function(option_type, options)
	if type(options) ~= "table" then
		error('options should be a type of "table"')
		return
	end
	local vim_option = vim[option_type]
	for key, value in pairs(options) do
		vim_option[key] = value
	end
end

-- enable builtin cfilter to filter quickfix lists
vim.cmd([[
packadd cfilter
]])

local Option = {}
Option.g = function(options)
	add_options(Type.GLOBAL_OPTION, options)
end
Option.w = function(options)
	add_options(Type.WINDOW_OPTION, options)
end
Option.b = function(options)
	add_options(Type.BUFFER_OPTION, options)
end

Option.g({
	ignorecase = true,
	termguicolors = true,
	mouse = "a",
	clipboard = "unnamedplus",
	hidden = true,
	showmode = false,
	-- not sure why this was 3000, trying 100 for which-key
	-- timeoutlen = 3e3,
	timeoutlen = 200,
	tabstop = 2,
	shiftwidth = 2,
	expandtab = true,
	conceallevel = 0,
	laststatus = 2,
	wrap = true,
	linebreak = true,
	list = true,
	listchars = "tab:»·,trail:·",
	wildmenu = true,
	wildmode = "full",
	autoread = true,
	-- updatetime = 500,
	updatetime = 300,
	redrawtime = 500,
  -- fillchars = vim.o.fillchars:append('')
	--illchars = vim.o.fillchars .. "vert:│",
	undofile = true,
	virtualedit = "onemore",
	guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20",
	complete = ".,w,b,u,t,k",
	completeopt = "menu,menuone,noinsert,noselect",
	formatoptions = "jtcroql",
	inccommand = "nosplit",
	shortmess = "atIcF",
	isfname = table.concat(
		vim.tbl_filter(function(entry)
			if entry == "=" then
				return false
			else
				return true
			end
		end, vim.split(vim.o.isfname, ",")),
		","
	),
	swapfile = false,
	diffopt = "internal,filler,closeoff,algorithm:patience,iwhiteall",
	splitbelow = true,
	splitright = true,
	backup = false,
	writebackup = false,
	cursorline = true,
	-- cursorcolumn = true,
	emoji = false,
	indentexpr = "nvim_treesitter#indent()",
})
Option.b({
	-- allows editing quickfix list. i.e. dd should remove an entry
	-- modifiable = true,
	swapfile = false,
	shiftwidth = 2,
	indentexpr = "nvim_treesitter#indent()",
})
Option.w({
	number = true,
	relativenumber = false,
	numberwidth = 1,
	signcolumn = "yes",
	spell = false,
	foldlevel = 99,
	foldmethod = "manual",
	foldexpr = "nvim_treesitter#foldexpr()",
	foldtext = "v:lua.foldText()",
	linebreak = true,
})

if vim.fn.has("mac") == 1 then
	vim.g.clipboard = {
		name = "macOS-clipboard",
		copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
		paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
		cache_enabled = false,
	}
	-- TODO: put in clipboard for linux
else
end

vim.o.laststatus = 3 -- global statusline (feature as of nvim 0.7)
vim.g.mapleader = " "
vim.g.one_allow_italics = true
vim.g.oceanic_next_terminal_bold = true
vim.g.oceanic_next_terminal_italic = true
vim.g.vim_monokai_tasty_italic = true
vim.g.table_mode_corner = "|"
vim.g.markdown_fold_override_foldtext = false
vim.g.markdown_syntax_conceal = false
-- TODO: comment back in when working
-- vim.g.mkdp_auto_start = false
vim.g.vim_json_syntax_conceal = false

-- to help for faster loads
-- opt.lazyredraw = true
-- vim.g.vim.lazyredraw = truncate
vim.o.lazyredraw = true

-- disable built in features I'm not using to help with load
local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end


return Option
