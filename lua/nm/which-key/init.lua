local which_key = require("which-key")

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ...
			motions = false, -- adds help for motions
			text_objects = false, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
		spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
	},
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
}

local opts = {
	mode = "n", -- NORMAL mode
	-- the prefix is prepended to every mapping part of `mappings`
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	-- for i = 1, 9 do
	--   M.map("n", "<leader>" .. i, ':lua require"bufferline".go_to_buffer(' .. i .. ")<CR>")
	--   M.map("t", "<leader>" .. i, '<C-\\><C-n>:lua require"bufferline".go_to_buffer(' .. i .. ")<CR>")
	-- end
	b = {
		name = "Buffers",
		-- Confirm delete is right
		d = { ":BufDel<cr>", "Delete Buffer" },
		l = { "<cmd> Telescope buffers<cr>", "Buffer List" },
		n = { "<cmd>bnext<cr>", "Next Buffer" },
		p = { "<cmd>bprevious<cr>", "Previous Buffer" },
	},

	c = {
    name = "Turbo Console Log",
		l = { "<cmd>Logsitter<cr>", "Log highlighted var" },
	},
	C = { "<cmd>Telescope colors<cr>", "Colorschemes" },

	d = {
		name = "Diagnostics",
		j = {
			"<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = 'single'}})<cr>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = 'single'}})<cr>",
			"Prev Diagnostic",
		},
	},

	D = {
		name = "Debug",
		b = {
			"<cmd>lua require('dap').toggle_breakpoint() <cr>",
			"Toggle Breakpoint",
		},
	},

	f = {
		name = "Files", -- optional group name
		f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
		h = { "<cmd>lua require('nm.telescope').find_files()<cr>", "Find File" }, -- create a binding with label
		g = { "<cmd>Telescope git_files<cr>", "Git Files" }, -- create a binding with label
		i = { "<cmd>lua require('nm.telescope').git_files()<cr>", "Git Files (Custom)" }, -- create a binding with label
		o = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" }, -- create a binding with label
		s = { "<cmd>Telescope live_grep<cr>", "Live Grep" }, -- create a binding with label

		n = { "New File" }, -- just a label. don't create any mapping
		e = "Edit File", -- same as above
		-- ["1"] = "which_key_ignore",  -- special label to hide it in the popup
		-- b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
	},

	g = {
		name = "Git",
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		C = {
			"<cmd>Telescope git_bcommits<cr>",
			"Checkout commit(for current file)",
		},
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Git Diff",
		},
	},

	h = {
		name = "Help",
		t = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
		k = { "<cmd>Telescope keymaps<cr>", "Mappings" },
	},

	l = {
		name = "Lsp",
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
		a = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", "Refresh Codelens" },
		c = { "<cmd>lua vim.lsp.codelens.run()<cr>", "Run Codelens" },
		d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Document Diagnostics" },
		D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
		f = { "<cmd>lua vim.lsp.buf.formatting_sync()<cr>", "Format" },
		h = { "<cmd>lua require('lspsaga.hover').render_hover_doc()<cr>", "Hover Type" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = 'single'}})<cr>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = 'single'}})<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>Trouble loclist<cr>", "Loc List" },
		m = { "<cmd>Trouble quickfix<cr>", "Quick Fix List" },
		o = { "<cmd>lua require('trouble').refresh({ open_folds = true })<cr>", "Trouble open all folds" },
		q = { "<cmd>Telescope lsp_code_actions<cr>", "Code Actions" },
		r = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
		s = { "<cmd>lua vim.lsp.signature_help()<cr>", "Signature Help" },
		t = { "<cmd>Trouble<cr>", "Trouble Plugin" },
		w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" },
		z = { "<cmd>lua require('trouble').refresh({ close_folds = true })<cr>", "Trouble close all folds" },
	},

	L = {
		name = "Luasnip",
		s = { "<cmd>source ~/.config/nvim/lua/nm/luasnip/init.lua<CR>", "Source" },
	},

	n = {
		name = "Nvim",
		f = { "<cmd>lua require('nm.telescope').nvim_files()<cr>", "Config Files" },
	},

	p = {
		name = "Packer",
		c = { "<cmd>PackerClean<cr>", "Clean" },
		h = { "<cmd>PackerStatus<cr>", "Status" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	-- TODO: update these grep calls to use custom nm module to pass in the window settings I want for these results
	s = {
		name = "Search",
		p = {
			"<cmd>lua require('telescope.builtin').live_grep{ cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1] }<cr>",
			"Grep project",
		},
		a = {
			"<cmd>lua require('telescope.builtin').grep_string{ cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1] }<cr>",
			"Find all occurrences (project)",
		},
		-- e = { "<cmd>lua require('nm.telescope').live_grep_project{ cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1] }<cr>", "Grep project"},
		e = {
			"<cmd>lua require('nm.telescope').live_grep_exact_match{ cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1] }<cr>",
			"Grep project Exact Match",
		},
		-- e = { "<cmd>lua require('nm.telescope').live_grep_exact_match()<cr>", "Grep Exact Match, Use '\b word \b'" }, -- \b is a word boundary
	},

	S = {
		name = "Surround",
		-- TODO: put this in its own 'surround' key. Add the other surround bindings. Use :Telescope keymaps, type s to see more
		a = { "<cmd>set operatorfunc=SurroundAddOperatorMode<cr> g@", "Add" }, -- create a binding with label
		d = { "<cmd>lua require('surround').surround_delete()<cr>", "Delete" }, -- create a binding with label
		r = { "<cmd>lua require('surround').surround_replace()<cr>", "Replace" }, -- create a binding with label
		w = { "<cmd>set operatorfunc=SurroundAddOperatorMode<cr> g@iw", "Word" }, -- create a binding with label
	},

	t = {
		name = "Terminal",
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm direction=vertical<cr>", "Vertical" },
	},

	T = {
		name = "Telescope",
		-- todo: in the plugins file, put the projects extension command into its own projects/init.lua file
		p = { "<cmd>Telescope projects<cr>", "Projects" },
	},

  v = { "<cmd>lua require('telescope').extensions.neoclip.default()<cr>", "Clipboard" },

  ["?"] = { "<cmd>Trouble<cr>", "Trouble Plugin" }
}

which_key.setup(setup)

-- TODO: make normal mappings and vmappings/vopts
which_key.register(mappings, opts)
