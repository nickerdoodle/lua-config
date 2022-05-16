local actions = require("telescope.actions")

require("neoclip").setup({
	history = 20, -- default 1000
	enable_persistent_history = false, -- can use sqlite3 to store more things. Not using for now
	db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
	filter = nil,
	preview = true,
	default_register = '"',
	default_register_macros = "q",
	enable_macro_history = true, -- can search through macro history as well
	content_spec_column = false,
	on_paste = {
		set_reg = false,
	},
	on_replay = {
		set_reg = false,
	},
	keys = {
		telescope = {
			i = {
				select = "<tab>",
				paste = "<cr>",
				paste_behind = "<c-cr>",
				-- select = "<cr>",
				-- paste = "<c-p>",
				-- paste_behind = "<c-k>",
				replay = "<c-q>",
				custom = {
					-- ["<C-p>"] = actions.move_selection_previous,
					-- ["<C-p>"] = "<Up>",
					-- ["<C-p>"] = function(opts)
					-- 	return actions.move_selection_previous
					-- end,
					["<C-m>"] = function(opts)
            print(vim.inspect(opts))
					end,
					["<C-p>"] = function(opts)
            -- print(vim.inspect(opts))
            -- vim.fn.feedkeys("asdf")
            -- vim.cmd([[\<Cmd>call feedkeys('<C-w>k')<CR>]])
						-- actions.move_selection_previous()
            -- vim.cmd([[<Cmd><Up>]])
					end,
				},
			},
			n = {
				select = "<tab>",
				paste = "<cr>",
				paste_behind = "<c-cr>",
				-- select = "<cr>",
				-- paste = "p",
				-- paste_behind = "P",
				replay = "q",
				custom = {
					-- ["<C-p>"] = actions.move_selection_previous,
					["<C-p>"] = function(opts)
						-- return actions.move_selection_previous
					end,
				},
			},
		},
		fzf = {
			select = "<tab>",
			paste = "<cr>",
			paste_behind = "<c-cr>",
			-- select = "default",
			-- paste = "ctrl-p",
			-- paste_behind = "ctrl-k",
			custom = {
				-- ["<C-p>"] = actions.move_selection_previous,
					["<C-p>"] = function(opts)
						-- return actions.move_selection_previous
					end,
			},
		},
	},
})
