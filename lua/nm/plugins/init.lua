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
	-- use {"tpope/vim-surround"}
	-- this will probably replace vim-surround
	use({
		"blackCauldron7/surround.nvim",
		config = function()
			-- require "surround".setup {}
			require("surround").setup({ mappings_style = "surround" })
		end,
	})
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
	-- use({
	-- 	"lewis6991/gitsigns.nvim",
	-- 	requires = {
	-- 		"nvim-lua/plenary.nvim",
	-- 	},
	-- 	config = function()
	-- 		require("gitsigns").setup({
	-- 			--[[ signs = {
	--            add = {hl = "GitGutterAdd", text = "│"},
	--            change = {hl = "GitGutterChange", text = "│"},
	--            delete = {hl = "GitGutterDelete", text = "_"},
	--            topdelete = {hl = "GitGutterDelete", text = "‾"},
	--            changedelete = {hl = "GitGutterChangeDelete", text = "~"}
	--          } ]]
	-- 			signs = {
	-- 				--[[ add          = {hl = '#140', text = '│', numhl='#140'   , linehl='#140'},
	--            change       = {hl = '#140', text = '│', numhl='#140', linehl='#140'}, ]]
	-- 				-- add          = {hl = 'GitSignsAdd', text = '│', numhl='#140'   , linehl='#140'},
	-- 				add = { hl = "GitSignsAdd", text = "│", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
	-- 				change = {
	-- 					hl = "GitSignsChange",
	-- 					text = "│",
	-- 					numhl = "GitSignsChangeNr",
	-- 					linehl = "GitSignsChangeLn",
	-- 				},
	-- 				-- change       = {hl = '#140', text = '│', numhl='#140', linehl='#140'},
	-- 				delete = {
	-- 					hl = "GitSignsDelete",
	-- 					text = "_",
	-- 					numhl = "GitSignsDeleteNr",
	-- 					linehl = "GitSignsDeleteLn",
	-- 				},
	-- 				topdelete = {
	-- 					hl = "GitSignsDelete",
	-- 					text = "‾",
	-- 					numhl = "GitSignsDeleteNr",
	-- 					linehl = "GitSignsDeleteLn",
	-- 				},
	-- 				changedelete = {
	-- 					hl = "GitSignsChange",
	-- 					text = "~",
	-- 					numhl = "GitSignsChangeNr",
	-- 					linehl = "GitSignsChangeLn",
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- })
	use("sindrets/diffview.nvim")
	use({
		"TimUntersberger/neogit",
		requires = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
		},
	})

	use({
		"tanvirtin/vgit.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
	})

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
	use({ "jose-elias-alvarez/null-ls.nvim" })

	-- TODO: may not need lspsaga much anymore since core neovim allows us to extend the ui implementation with packages like dressing
	use({ "glepnir/lspsaga.nvim" })

	-- provides floating window for function signatures
	use({
		"ray-x/lsp_signature.nvim",
	})

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
	-- use({
	-- 	"nvim-telescope/telescope-frecency.nvim",
	-- 	config = function()
	-- 		require("telescope").load_extension("frecency")
	-- 	end,
	-- 	requires = { "tami5/sqlite.lua" },
	-- })

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
	use({ "Pocco81/DAPInstall.nvim" })
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

	use({
		"David-Kunz/jester",
	})

	-- similar to turbo console log in vscode. automated logging
	use({ "gaelph/logsitter.nvim", requires = { "nvim-treesitter/nvim-treesitter" } })

	-- for faster startup by caching
	use("lewis6991/impatient.nvim")
	-- faster startup by improving assigning the filetype var
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

	-- training
	use({ "tjdevries/train.nvim" })

	-- add these
	-- https://github.com/SmiteshP/nvim-gps
end)
