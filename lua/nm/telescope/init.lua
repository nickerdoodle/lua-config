local vim = vim
local telescope = require("telescope")
local builtIn = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

-- Built-in actions
local transform_mod = require('telescope.actions.mt').transform_mod

-- or create your custom action
local nicks_custom_actions = transform_mod({
  print_test = function(prompt_bufnr)
    print("This function ran after another action. Prompt_bufnr: " .. prompt_bufnr)
    -- trouble.open_with_trouble()
    -- vim.cmd('wincmd H')
    -- vim.cmd('vertical resize 55')
    -- Enter your function logic here. You can take inspiration from lua/telescope/actions.lua
  end,
  -- save this function as example. Trouble wasn't opening on the left side previously, so I created this as a workaround
  -- but we can still do a lot with this in the future for other plugins
  open_with_trouble = function(prompt_bufnr)
    trouble.open_with_trouble(prompt_bufnr)
    vim.cmd('wincmd H')
    vim.cmd('vertical resize 55')
  end,
})

telescope.setup({
	defaults = {
		mappings = {},
	},
})

local M = {}

telescope.load_extension("gh")
-- commented this out. an update to repo might mean i don't need it anymore
-- telescope.load_extension("node_modules")
telescope.load_extension("packer")

telescope.setup({
	pickers = {
		buffers = {
			sort_lastused = true,
		},
	},
	defaults = {
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		mappings = {
			i = {
				["<esc>"] = actions.close,
				-- ["<CR>"] = actions.goto_file_selection_edit,
				["<CR>"] = actions.select_default + actions.center,
				["<Tab>"] = actions.toggle_selection,
				["<c-u>"] = actions.delete_buffer,
				["<c-j>"] = actions.preview_scrolling_down,
				["<c-k>"] = actions.preview_scrolling_up,
				["<c-t>"] = trouble.open_with_trouble,
				-- ["<c-t>"] = nicks_custom_actions.print_test,
				-- ["<c-t>"] = nicks_custom_actions.open_with_trouble,

			},
			n = {
				["<c-t>"] = trouble.open_with_trouble,
			},
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = false, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
		-- slow startup, not liking it. Maybe revisit in future
		--   frecency = {
		--   db_root = "~/.local/share/nvim/",
		--   show_scores = false,
		--   show_unindexed = true,
		--   ignore_patterns = {"*.git/*", "*/tmp/*"},
		--   disable_devicons = false,
		--   -- workspaces = {
		--   --   ["conf"]    = "/home/my_username/.config",
		--   --   ["data"]    = "/home/my_username/.local/share",
		--   --   ["project"] = "/home/my_username/projects",
		--   --   ["wiki"]    = "/home/my_username/wiki"
		--   -- }
		-- }
	},
})
local function generateOpts(opts)
	local common_opts = {
		layout_strategy = "horizontal",
		-- layout_strategy = "vertical",
		-- sorting_strategy = "ascending",
		sorting_strategy = "descending",
		results_title = false,
		preview_title = "Preview",
		-- show first letter for directories
		path_display = {
			shorten = 5,
		},
		layout_config = {
			height = 90,
			width = 140,
			preview_width = 0.45,
		},
		-- layout_config = {
		--   -- height = 25
		--   width = 100,
		--   prompt_position = "top",

		-- },
		-- preview_position = "bottom",
		-- layout_config = {
		--   horizontal = {
		--       -- prompt_position = "top",
		--       -- preview_width = 0.55,
		--       -- results_width = 0.8
		--       mirror = false
		--   },
		--   vertical = {
		--       prompt_position = "bottom",
		--       preview_height = 0.55,
		--       results_height= 0.8
		--       -- mirror = false
		--   },
		--   width = 0.87,
		--   height = 0.80,
		--   preview_cutoff = 120
		-- },
		-- previewer = false,
		borderchars = {
			{ "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
			prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
			results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
			preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		},
	}
	return vim.tbl_extend("force", opts, common_opts)
end
--[[ function M.colors()
  local opts = generateOpts({})
  builtIn.colorscheme(opts)
end ]]
function M.find_files()
	local cmn_opts = generateOpts({})
	cmn_opts.find_command = { "rg", "--files", "-L", "--glob", "!.git" }
	-- cmn_opts.find_command = {"rg", "--ignore", "--hidden", "--files", "-L", "--glob", "!.git" }
	builtIn.find_files(cmn_opts)
end

function M.git_files()
	local cmn_opts = generateOpts({})
	builtIn.git_files(cmn_opts)
end

function M.nvim_files()
	local opts = {
		cwd = "~/.config/nvim/",
		prompt_title = "Nvim Files",
	}
	local cmn_opts = generateOpts(opts)
	builtIn.find_files(cmn_opts)
end

function M.live_grep_project()
	local opts = {
		prompt_title = "Live Grep Project",
	}
	local cmn_opts = generateOpts(opts)
	builtIn.live_grep(cmn_opts)
end

function M.live_grep_exact_match()
	local opts = {
		prompt_title = "Live Grep Project Exact Match (surround word with escape char b)",
		vimgrep_arguments = {
			"rg",
			-- "--fixed-strings", -- does not use regex
			-- "--follow",
			-- "--color=never",
			"--no-heading", -- required for cmd to work
			"--with-filename", -- required for cmd to work
			"--line-number", -- required for cmd to work
			"--column", -- required for cmd to work
			"--smart-case",
		},
		cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1],
	}

	local cmn_opts = generateOpts(opts)
	builtIn.live_grep(cmn_opts)
end

function M.help_tags()
	local opts = generateOpts({})
	builtIn.help_tags(opts)
end

return M
