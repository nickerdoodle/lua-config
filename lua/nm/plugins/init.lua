-- PLUGINS TO TRY AND TEST out
-- octo - github issues and pull requests

local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
	execute("packadd packer.nvim")
end

--[[ local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end ]]

-- Neovim version manager, see repo for how to use
-- https://github.com/MordechaiHadad/bob

return require("packer").startup(function(use)
	-- Packer can manage itself as an optional plugin
	use({ "wbthomason/packer.nvim" })
	-- basically does autopairing
	-- use {"Raimondi/delimitMate"}
	--
	use({ "tpope/vim-repeat" })
	-- use {"tpope/vim-unimpaired"}
	-- you define options a text can be and an easy way to switch it
	-- change true to false or => to -> you can add as many options as you want
	-- use {"AndrewRadev/switch.vim"}
	-- I'm not using tmux for now
	-- use {"christoomey/vim-tmux-navigator"}
	-- use({ "tpope/vim-surround" })
	-- this will probably replace vim-surround
	-- commenting this because I think the repo was deleted. Still looking for a nvim surround plugin. using vim one for now
	-- use({
	-- using nvim-surround now. MUCH BETTER. Get basic commands here https://github.com/kylechui/nvim-surround/wiki/getting-started-for-beginners
	use({ "kylechui/nvim-surround" })
	-- 	"blackCauldron7/surround.nvim",
	-- 	config = function()
	-- 		-- require "surround".setup {}
	-- 		require("surround").setup({ mappings_style = "surround" })
	-- 	end,
	-- })
	-- comment plugin. Probably don't need
	-- use {"tyru/caw.vim"}
	-- use {"junegunn/vim-easy-align"}
	-- use {"tmux-plugins/vim-tmux"}
	-- not sure if I need this. Probabaly not
	-- use {"Shougo/context_filetype.vim"}
	-- reduces commands to close windows/buffers. I don't really think I need this for now
	-- use {"mhinz/vim-sayonara"}
	-- buffer deletion
	use({ "ojroques/nvim-bufdel" })
	-- multi cursors
	-- use {"mg979/vim-visual-multi"}
	-- this seems old and I probably don't need
	-- use {"MartinLafreniere/vim-PairTools"}
	-- helps for usage in iTerm2 and tmux
	-- use {"sjl/vitality.vim"}

	use({ "kyazdani42/nvim-tree.lua" })

	-- Comments
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- nerdtree. pending to ditch
	-- use {"preservim/nerdtree"}
	-- use {"Xuyuanp/nerdtree-git-plugin"}
	-- use {"Xuyuanp/yanil"}

	-- shows the lines for the indents and spaces
	-- use {"Yggdroot/indentLine"}
	-- use {"hoob3rt/lualine.nvim"}

	-- Statusline
	use({ "glepnir/galaxyline.nvim" })
	-- alternative could be barbar.nvim look at it sometime
	use({ "akinsho/nvim-bufferline.lua" })

	-- Colors
	--[[ use {"morhetz/gruvbox"}
    use {"patstockwell/vim-monokai-tasty"}
    use {"arzg/vim-colors-xcode"}
    use {"chuling/vim-equinusocio-material"}
    use {"romgrk/github-light.vim"}
    use {"Khaledgarbaya/night-owl-vim-theme"}
    use {"kenwheeler/glow-in-the-dark-gucci-shark-bites-vim"}
    use {"TroyFletcher/vim-colors-synthwave"}
    use {"bluz71/vim-nightfly-guicolors"} ]]

	use("folke/tokyonight.nvim")

	-- vscode colors
	use("Mofiqul/vscode.nvim")

	-- Editor Config
	-- use {"editorconfig/editorconfig-vim"}
	-- Git
	-- use {"tpope/vim-fugitive"}
	-- use {"tpope/vim-rhubarb"}
	-- use {"sgeb/vim-diff-fold"}
	use({
		"lewis6991/gitsigns.nvim",
	})

	use("sindrets/diffview.nvim")
	use({
		"TimUntersberger/neogit",
		requires = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
		-- config = function ()
		--   require('diffview').setup({
		--     enhanced_diff_hl = true,
		--   })
		--
		-- end
	})

	-- switching back to gitsigns
	-- use({
	-- 	"tanvirtin/vgit.nvim",
	-- 	requires = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- })

	-- -- Markdown
	-- use {"tpope/vim-markdown", ft = "markdown"}
	-- use {"nelstrom/vim-markdown-folding", ft = "markdown"}
	-- use {"dhruvasagar/vim-table-mode"}
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
	})
	-- Rust
	-- use {"rust-lang/rust.vim"}
	-- use {"racer-rust/vim-racer"}
	-- Python
	-- use {"tmhedberg/SimpylFold", ft = "python"}
	-- JS/TS
	-- with tree sitter, this might not be needed
	--[[ use {"othree/yajs.vim"}
    use {"MaxMEllon/vim-jsx-pretty"}
    use {"heavenshell/vim-jsdoc"}
    use {"elzr/vim-json"}
    use {"HerringtonDarkholme/yats.vim"}
    use {"Quramy/vison"}
    use {"jxnblk/vim-mdx-js"} ]]
	-- HTML
	--[[ use {"othree/html5.vim"}
    use {"mattn/emmet-vim"}
    use {"posva/vim-vue"}
    use {"leafOfTree/vim-svelte-plugin"}
    use {"skwp/vim-html-escape"}
    use {"kana/vim-textobj-user"}
    use {"whatyouhide/vim-textobj-xmlattr"}
    use {"pedrohdz/vim-yaml-folds"} ]]
	-- CSS
	-- use {"hail2u/vim-css3-syntax"}
	use({
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	})
	-- Swift
	--[[ use {"keith/swift.vim"}
    use {"gfontenot/vim-xcode"} ]]
	-- Reason
	-- use{ "reasonml-editor/vim-reason-plus" }
	-- Go
	-- use{ "fatih/vim-go" }
	-- Lua syntax indentation
	-- use {"tbastos/vim-lua"}

	-- mhartington
	--[[ use {"mhartington/formatter.nvim"}
    use {"mhartington/vim-folds"} ]]
	-- use {"mhartington/oceanic-next"}

	-- treesitter
	-- use {"nvim-treesitter/nvim-treesitter"}
	use({
		"nvim-treesitter/nvim-treesitter",
		-- event = "BufRead",
		run = ":TSUpdate",
	})

	-- is this causing errors in the checkhealth. Looks like it's causing slowness in projects
	-- use {"nvim-treesitter/nvim-treesitter-angular"}
	-- get this working on install
	use({ "nvim-treesitter/playground" })

	use({ "windwp/nvim-ts-autotag" })

	-- snippets
	-- might remove snippets
	-- use {"norcalli/snippets.nvim"}
	-- vsnip allows using any vscode snippet extension and it will be added to the vsnip list
	-- use {"hrsh7th/vim-vsnip"}
	-- use {"hrsh7th/vim-vsnip-integ"}
	use({ "johnpapa/vscode-angular-snippets" })
	use({ "xabikos/vscode-javascript" })
	-- use {"sidthesloth92/vsc_html5_boilerplate"}

	-- this has a large collection of snippets. would be ideal to use this eventually
	use({ "rafamadriz/friendly-snippets" })
	--[[ use {"Shougo/deoplete.nvim", run = "remote#host#UpdateRemotePlugins()"}
    use {"shougo/deoplete-lsp"} ]]

	-- lsp
	-- might not need completion. using compe
	-- use {"nvim-lua/completion-nvim"}
	-- compe is deprecated. Now cmp
	-- use {"hrsh7th/nvim-compe"}
	-- cmp is newer version of compe
	-- Install nvim-cmp, and buffer source as a dependency
	-- use({ "hrsh7th/cmp-vsnip" })
	use({
		"L3MON4D3/LuaSnip",
		-- after = "nvim-cmp",
		-- config = function()
		-- 	require("nm.luasnip")
		-- end,
	})
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			-- "hrsh7th/cmp-vsnip",
			-- "hrsh7th/vim-vsnip",
			-- "hrsh7th/vim-vsnip-integ",
			"saadparwaiz1/cmp_luasnip",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp-document-symbol",
			"hrsh7th/cmp-nvim-lsp-signature-help",
		},
	})
	--   use {
	--   'hrsh7th/nvim-cmp',
	--   config = function ()
	--     require'cmp'.setup {
	--     snippet = {
	--       expand = function(args)
	--         require'luasnip'.lsp_expand(args.body)
	--       end
	--     },

	--     sources = {
	--       { name = 'luasnip' },
	--       -- more sources
	--     },
	--   }
	--   end
	-- }
	-- use { 'saadparwaiz1/cmp_luasnip' }
	use({ "onsails/lspkind-nvim" })

	-- provides commands to easily install different language servers
	use({
		"neovim/nvim-lspconfig",
		"williamboman/nvim-lsp-installer",
	})

	-- Uses the builtin lsp support to provide formatting, linting, and other features
	use({
		"jose-elias-alvarez/null-ls.nvim",
		-- breaking changes after this commit on neovim 0.8. Use this until fixed
		-- commit = 'bd9dfc6015241334c140fb065445ba9443e6de14',
		requires = { "nvim-lua/plenary.nvim" },
		debug = true,
	})

	-- TODO: may not need lspsaga much anymore since core neovim allows us to extend the ui implementation with packages like dressing
	use({ "glepnir/lspsaga.nvim" })

	-- provides floating window for function signatures
	-- use({
	-- 	"ray-x/lsp_signature.nvim",
	-- })

	-- telescope advanced search
	use({ "nvim-lua/popup.nvim" })
	use({ "nvim-lua/plenary.nvim" })
	-- use {"nvim-telescope/telescope.nvim"}
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make",
			},
		},
	})
	use({ "nvim-telescope/telescope-github.nvim" })
	-- packer is causing the PackerUpdate issues
	use({ "nvim-telescope/telescope-packer.nvim" })
	use({ "nvim-telescope/telescope-node-modules.nvim" })
	-- turned off because not liking it
	-- smart suggestions for files when searching
	use({
		"nvim-telescope/telescope-frecency.nvim",
		config = function()
			require("telescope").load_extension("frecency")
		end,
		requires = { "tami5/sqlite.lua" },
	})

	use({
		"pwntester/octo.nvim",
		requires = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("octo").setup()
		end,
	})

	-- autopairs
	use({ "windwp/nvim-autopairs" })

	-- autoclosing for html
	-- use {"windwp/nvim-ts-autotag"}

	-- start menu
	use({ "mhinz/vim-startify" })
	-- search with f and t
	-- use {"unblevable/quick-scope"}

	-- check this out sometime. rapidly hop across page
	-- use {"phaazon/hop.nvim"}
	-- highlights the same words in buffer
	-- use {"RRethy/vim-illuminate"}
	-- TODO: look into quickfixes and if I want this
	-- use {"kevinhwang91/nvim-bqf"}
	-- try sometime. html preview
	-- use {"turbio/bracy.vim"}

	-- icons
	use({
		"kyazdani42/nvim-web-devicons",
		config = function()
			require("nvim-web-devicons").setup({
				overrides = {
					git = { icon = "" },
					js = { icon = "" },
					vim = { icon = "" },
					css = { icon = "" },
					html = { icon = "" },
					json = { icon = "" },
					md = { icon = "" },
					sql = { icon = "" },
				},
			})
		end,
	})
	-- Lua
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		-- config = function()
		-- 	require("trouble").setup({
		-- 		position = "left", -- position of the list can be: bottom, top, left, right
		-- 	})
		-- end,
		--[[ {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
          } ]]
		--[[ )
      end ]]
	})

	-- Better UI components for core neovim commands using neovim UI api's
	use({ "stevearc/dressing.nvim" })

	-- Search icons/emojis/fonts with telescope
	use({
		"ziontee113/icon-picker.nvim",
	})

	use({
		-- TODO: using a patch branch for breaking change. Check if it's fixed periodically
		-- 'zeertzjq/which-key.nvim',
		-- branch='patch-1',
		"folke/which-key.nvim",
		-- config = function()
		--   require("which-key").setup {
		--     -- your configuration comes here
		--     -- or leave it empty to use the default settings
		--     -- refer to the configuration section below
		--   }
		-- end
	})

	-- a legend for which-key similar to command palette
	-- Called in the which-key config file
	use({ "mrjones2014/legendary.nvim" })

	-- terminal
	use({ "akinsho/toggleterm.nvim" })

	-- project management
	-- Lua
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	require("telescope").load_extension("projects")

	use({ "kaputi/e-kaput.nvim" })

	--   require('e-kaput').setup({
	--  -- defaults
	--   enabled = true, -- true | false,  Enable EKaput.
	--   transparency = 25, -- 0 - 100 , transparecy percentage.
	--   borders = true, -- true | false, Borders.
	--   error_sign = '', -- Error sign.
	--   warning_sign = '', -- Warning sign.
	--   information_sign = '', -- Information sign.
	--   hint_sign = '' -- Hint sign.
	-- })

	-- Debugging
	use({ "mfussenegger/nvim-dap" })
	-- DapInstall changed to dap-buddy
	-- use({ "Pocco81/DAPInstall.nvim" })
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

	use({
		"David-Kunz/jester",
	})

	-- similar to turbo console log in vscode. automated logging
	use({ "gaelph/logsitter.nvim", requires = { "nvim-treesitter/nvim-treesitter" } })

	-- for faster startup by caching
	use("lewis6991/impatient.nvim")
	-- faster startup by improving assigning the filetype var
	-- commenting because it conflicts with syntax highlighting for quickfix preview window
	use("nathom/filetype.nvim")

	-- shows path to highlighted function in statusline
	use({
		"SmiteshP/nvim-gps",
		requires = "nvim-treesitter/nvim-treesitter",
	})

	-- remove
	-- use({"glepnir/indent-guides.nvim"})
	use("lukas-reineke/indent-blankline.nvim")

	-- to mimic vscode's call hierarchy
	use({ "ldelossa/litee.nvim" })
	use({ "ldelossa/litee-filetree.nvim" })
	use({ "ldelossa/litee-calltree.nvim" })
	use({ "ldelossa/litee-symboltree.nvim" })

	use({
		"AckslD/nvim-neoclip.lua",
		requires = {
			{ "nvim-telescope/telescope.nvim" },
		},
	})

	-- side menu of functions, classes in file
	use({ "simrat39/symbols-outline.nvim" })

	-- quickfix
	use({ "kevinhwang91/nvim-bqf" })

	-- allow quickfix to be modifiable (delete, run ex commands)
	use({ "stefandtw/quickfix-reflector.vim" })

	-- toggle qf lists, few other things
	use({
		"ten3roberts/qf.nvim",
		config = function()
			require("qf").setup({
				-- Location list configuration
				l = {
					auto_close = false, -- Automatically close location/quickfix list if empty
					auto_follow = "prev", -- Follow current entry, possible values: prev,next,nearest, or false to disable
					auto_follow_limit = 8, -- Do not follow if entry is further away than x lines
					follow_slow = true, -- Only follow on CursorHold
					auto_open = true, -- Automatically open list on QuickFixCmdPost
					auto_resize = true, -- Auto resize and shrink location list if less than `max_height`
					max_height = 8, -- Maximum height of location/quickfix list
					min_height = 5, -- Minimum height of location/quickfix list
					wide = false, -- Open list at the very bottom of the screen, stretching the whole width.
					number = false, -- Show line numbers in list
					relativenumber = false, -- Show relative line numbers in list
					unfocus_close = false, -- Close list when window loses focus
					focus_open = false, -- Auto open list on window focus if it contains items
					close_other = false, -- Close quickfix list when location list opens
				},
				-- Quickfix list configuration
				c = {
					auto_close = false, -- Automatically close location/quickfix list if empty
					auto_follow = "prev", -- Follow current entry, possible values: prev,next,nearest, or false to disable
					auto_follow_limit = 8, -- Do not follow if entry is further away than x lines
					follow_slow = true, -- Only follow on CursorHold
					auto_open = true, -- Automatically open list on QuickFixCmdPost
					auto_resize = true, -- Auto resize and shrink location list if less than `max_height`
					max_height = 8, -- Maximum height of location/quickfix list
					min_height = 5, -- Minimum height of location/quickfix list
					wide = false, -- Open list at the very bottom of the screen, stretching the whole width.
					number = false, -- Show line numbers in list
					relativenumber = false, -- Show relative line numbers in list
					unfocus_close = false, -- Close list when window loses focus
					focus_open = false, -- Auto open list on window focus if it contains items
					close_other = false, -- Close location list when quickfix list opens
				},
			})
		end,
	})

	-- smooth scroll
	-- use({ "karb94/neoscroll.nvim" })
	--
	-- enlarges the active buffer in the window. Has been more of a headache then good
	-- use({
	-- 	"beauwilliams/focus.nvim",
	-- 	config = function()
	-- 		require("focus").setup()
	-- 	end,
	-- })
	--
	-- Or lazy load with `module` option. See further down for info on how to lazy load when using FocusSplit commands
	-- Or lazy load this plugin by creating an arbitrary command using the cmd option in packer.nvim
	use({
		"beauwilliams/focus.nvim",
		cmd = { "FocusSplitNicely", "FocusSplitCycle" },
		module = "focus",
		config = function()
			require("focus").setup({ hybridnumber = true, excluded_filetypes = { "toggleterm" }, autoresize = false })
		end,
	})

	-- training
	use({ "tjdevries/train.nvim", ft = "qf" })

	-- look into
	-- similar setup for task.json or launch.json configs in vscode
	-- https://github.com/pianocomposer321/yabs.nvim
	-- https://github.com/ThePrimeagen/refactoring.nvim
	-- https://github.com/bennypowers/nvim-regexplainer
	use({
		"bennypowers/nvim-regexplainer",
		config = function()
			require("regexplainer").setup()
		end,
		requires = {
			"nvim-treesitter/nvim-treesitter",
			"MunifTanjim/nui.nvim",
		},
	})

	-- use({
	-- 	"bfredl/nvim-luadev",
	-- 	config = function()
	-- 		require("nvim-luadev").setup()
	-- 	end,
	-- })

	use({ "nvim-treesitter/nvim-treesitter-context" })

	-- see hover doc in side view
	use({
		"amrbashir/nvim-docs-view",
	})

	use({
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup()
		end,
	})

	use({
		"ldelossa/gh.nvim",
		requires = { { "ldelossa/litee.nvim" } },
	})

	use({
		"EthanJWright/vs-tasks.nvim",
		requires = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
	})

	use({
		"nvim-neotest/neotest",
		requires = {
			"nvim-lua/plenary.nvim",
			"nvim-treesitter/nvim-treesitter",
			"antoinemadec/FixCursorHold.nvim",
		},
	})

  -- https://github.com/nvim-neorg/neorg?ref=morioh.com&utm_source=morioh.com
  -- https://github.com/williamboman/mason.nvim
	-- https://github.com/stevearc/overseer.nvim#dap supposedly this will work with launch.json. try this
	-- https://github.com/vim-test/vim-test/ run c# tests with https://github.com/nvim-neotest/neotest
	-- https://github.com/ziontee113/color-picker.nvim
	-- https://github.com/ldelossa/gh.nvim this one is AWESOME
	-- https://github.com/ghillb/cybu.nvim
	-- https://github.com/axieax/urlview.nvim
	-- https://github.com/ggandor/leap.nvim
	-- https://github.com/ziontee113/syntax-tree-surfer
	-- https://github.com/mfussenegger/nvim-treehopper
end)
