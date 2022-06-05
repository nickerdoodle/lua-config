local vim = vim
local telescope = require("telescope")
local builtIn = require("telescope.builtin")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local action_layout = require("telescope.actions.layout")

local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")

-- Built-in actions
local transform_mod = require("telescope.actions.mt").transform_mod

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
		vim.cmd("wincmd H")
		vim.cmd("vertical resize 55")
	end,
})

-- telescope.setup({
-- 	defaults = {
-- 		mappings = {},
-- 	},
-- })
--
--

local M = {}

local devicons = require("nvim-web-devicons")
local entry_display = require("telescope.pickers.entry_display")

local filter = vim.tbl_filter
function M.generate_test(opts)
	local default_icons, _ = devicons.get_icon("file", "", { default = true })

	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = vim.fn.strwidth(default_icons) },
			{ reamaining = true }, -- file_name
			{ remaining = true }, -- path
		},
	})

	local function make_display(entry)

		return displayer({
			{ entry.devicons, entry.devicons_highlight },
			{ entry.file_name, "TelescopeResultsIdentifier" },
			{ entry.dir_name, "Comment" },
		})
	end

	return function(line)
		-- print(line)

		local file_name = vim.fn.fnamemodify(line, ":p:t")
		local absolute_path_dir_name = vim.fn.fnamemodify(line, ":p:h")
    local relative_path_dir_name = vim.fn.fnamemodify(line, ':p:~:.')
		-- print('filename ' .. file_name)
		-- print('score ' .. score) -- score is coming up nil
		-- print('score_str ' .. score_str) -- score_str is coming up nil
		-- print('path ' .. path) -- path is coming up nil
		-- print("dir_name " .. dir_name) -- dir_name works
		local path = absolute_path_dir_name .. "/" .. file_name

		local icons, highlight = devicons.get_icon(line, string.match(line, "%a+$"), { default = true })

		return {
			-- value = score,
			ordinal = path,
			path = path,
			display = make_display,
			file_name = file_name,
			dir_name = relative_path_dir_name,
			devicons = icons,
			devicons_highlight = highlight,
		}
	end
end

-- keep just to reference until test function is complete
function M.gen_from_buffer_like_leaderf(opts)
	opts = opts or {}
	local default_icons, _ = devicons.get_icon("file", "", { default = true })

	local bufnrs = filter(function(b)
		return 1 == vim.fn.buflisted(b)
	end, vim.api.nvim_list_bufs())

	-- local max_bufnr = math.max(unpack(bufnrs))
	-- local bufnr_width = #tostring(max_bufnr)
	local bufnr_width = 4

	local max_bufname = 8
	-- local max_bufname = math.max(
	--   unpack(
	--     map(function(bufnr)
	--       return vim.fn.strdisplaywidth(vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":p:t"))
	--     end, bufnrs)
	--   )
	-- )

	local displayer = entry_display.create({
		separator = " ",
		items = {
			{ width = bufnr_width },
			{ width = 4 },
			{ width = vim.fn.strwidth(default_icons) },
			{ width = max_bufname },
			{ remaining = true },
		},
	})

	local make_display = function(entry)
		return displayer({
			{ entry.bufnr, "TelescopeResultsNumber" },
			{ entry.indicator, "TelescopeResultsComment" },
			{ entry.devicons, entry.devicons_highlight },
			entry.file_name,
			{ entry.dir_name, "Comment" },
		})
	end

	return function(entry)
		-- local bufname = entry.info.name ~= "" and entry.info.name or "[No Name]"
		-- local hidden = entry.info.hidden == 1 and "h" or "a"
		-- local readonly = vim.api.nvim_buf_get_option(entry.bufnr, "readonly") and "=" or " "
		-- local changed = entry.info.changed == 1 and "+" or " "
		-- local indicator = entry.flag .. hidden .. readonly .. changed
		-- local indicator = entry.flag .. readonly .. changed

		-- local dir_name = vim.fn.fnamemodify(bufname, ":p:h")
		-- local file_name = vim.fn.fnamemodify(bufname, ":p:t")

		-- local icons, highlight = devicons.get_icon(opts.name, string.match(opts.name, "%a+$"), { default = true })

		return {
			valid = true,

			-- value = bufname,
			value = opts.name,
			-- ordinal = entry.bufnr .. " : " .. file_name,
			ordinal = opts.name,
			display = make_display,

			bufnr = entry.bufnr,

			-- lnum = entry.info.lnum ~= 0 and entry.info.lnum or 1,
			-- indicator = indicator,
			-- devicons = icons,
			-- devicons_highlight = highlight,

			-- file_name = file_name,
			-- dir_name = dir_name,
			file_name = entry.name,
			dir_name = opts.name,

			-- opts.value = opts.name
			-- opts.ordinal = opts.name
			-- opts.display = make_display
		}
	end
end

-- return improved_list_view

-- Use in telescope buffers

-- this works as commandline
-- require("telescope.builtin").buffers({
-- ...
-- entry_maker = require('nm/telescope').gen_from_buffer_like_leaderf(),
-- })

--
--
--

-- local M = {}

telescope.load_extension("gh")
-- commented this out. an update to repo might mean i don't need it anymore
-- telescope.load_extension("node_modules")
telescope.load_extension("packer")

telescope.setup({
	pickers = {
    git_files = {
      theme = "dropdown",
    },
    live_grep = {
      --@usage don't include the filename in the search results
      only_sort_text = true,
    },
		buffers = {
			sort_lastused = true,
			-- entry_maker = M.gen_from_buffer_like_leaderf(),
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
        ["<C-u>"] = false, -- will clear the search
				["<c-d>"] = actions.delete_buffer,
				["<c-j>"] = actions.preview_scrolling_down,
				["<c-k>"] = actions.preview_scrolling_up,
				["<c-t>"] = trouble.open_with_trouble,
        ["<c-space>"] = action_layout.toggle_preview
				-- ["<c-t>"] = nicks_custom_actions.print_test,
				-- ["<c-t>"] = nicks_custom_actions.open_with_trouble,
			},
			n = {
				["<c-t>"] = trouble.open_with_trouble,
			},
		},
		-- commented out. Not sure why I'm using this.
		-- file_sorter = require("telescope.sorters").get_fuzzy_file,
	},
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
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

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")

local function generateOpts(opts)
	local common_opts = {
    -- pickers = {
    --   git_files = {
    --     theme = 'dropdown'
    --   }
    -- },
		-- entry_maker = M.gen_from_buffer_like_leaderf(),
		entry_maker = M.generate_test(),
		-- layout_strategy = "horizontal",
		-- layout_strategy = "vertical",
		sorting_strategy = "ascending", -- shows results either from the top or bottom of popup
		-- sorting_strategy = "descending",
		results_title = false,
		preview_title = "Preview",
		-- show first letter for directories
		path_display = {
			shorten = 5,
		},
		layout_config = {
			height = 35,
			-- height = 90,
			-- height = 30,
			width = 140,
			-- preview_width = 0.45, -- commenting because need horizontal strategy for this to be valid
		},
		-- layout_config = {
		--   -- height = 25
		--   width = 100,
		--   prompt_position = "top",

		-- },
		preview_position = "bottom",
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
		previewer = false,
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
  -- will use git_files and fall back to find_files if not a git repo
	local cmn_opts = generateOpts({})
  local ok = pcall(builtIn.git_files, cmn_opts)
  if not ok then builtIn.find_files(cmn_opts) end
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
