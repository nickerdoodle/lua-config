
-- PLUGINS TO TRY AND TEST out
-- octo - github issues and pull requests



local execute = vim.api.nvim_command
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end

--[[ local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end ]]

return require "packer".startup(
  function(use)
    -- Packer can manage itself as an optional plugin
    use {"wbthomason/packer.nvim"}
    -- basically does autopairing
    -- use {"Raimondi/delimitMate"}
    --
    use {"tpope/vim-repeat"}
    -- use {"tpope/vim-unimpaired"}
    -- you define options a text can be and an easy way to switch it
    -- change true to false or => to -> you can add as many options as you want
    -- use {"AndrewRadev/switch.vim"}
    -- I'm not using tmux for now
    -- use {"christoomey/vim-tmux-navigator"}
    -- use {"tpope/vim-surround"}
    -- this will probably replace vim-surround
    use {
      "blackCauldron7/surround.nvim",
      config = function()
        require "surround".setup {}
      end
    }
    -- comment plugin. Probably don't need
    -- use {"tyru/caw.vim"}
    -- use {"junegunn/vim-easy-align"}
    -- use {"tmux-plugins/vim-tmux"}
    -- not sure if I need this. Probabaly not
    -- use {"Shougo/context_filetype.vim"}
    -- reduces commands to close windows/buffers. I don't really think I need this for now
    -- use {"mhinz/vim-sayonara"}
    -- buffer deletion
    use {"ojroques/nvim-bufdel"}
    -- multi cursors
    -- use {"mg979/vim-visual-multi"}
    -- this seems old and I probably don't need
    -- use {"MartinLafreniere/vim-PairTools"}
    -- helps for usage in iTerm2 and tmux
    -- use {"sjl/vitality.vim"}


    use {"kyazdani42/nvim-tree.lua"}

    -- Comments
    use {'b3nj5m1n/kommentary'}

    -- nerdtree. pending to ditch
    -- use {"preservim/nerdtree"}
    -- use {"Xuyuanp/nerdtree-git-plugin"}
    -- use {"Xuyuanp/yanil"}

    -- shows the lines for the indents and spaces
    -- use {"Yggdroot/indentLine"}
    -- use {"hoob3rt/lualine.nvim"}

    -- Statusline
    use {"glepnir/galaxyline.nvim"}
    -- alternative could be barbar.nvim look at it sometime
    use {"akinsho/nvim-bufferline.lua"}

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

    use 'folke/tokyonight.nvim'


    -- Editor Config
    -- use {"editorconfig/editorconfig-vim"}
    -- Git
    -- use {"tpope/vim-fugitive"}
    -- use {"tpope/vim-rhubarb"}
    -- use {"sgeb/vim-diff-fold"}
    use {
      "lewis6991/gitsigns.nvim",
      requires = {
        'nvim-lua/plenary.nvim'
      },
      config = function()
        require "gitsigns".setup {
          --[[ signs = {
            add = {hl = "GitGutterAdd", text = "│"},
            change = {hl = "GitGutterChange", text = "│"},
            delete = {hl = "GitGutterDelete", text = "_"},
            topdelete = {hl = "GitGutterDelete", text = "‾"},
            changedelete = {hl = "GitGutterChangeDelete", text = "~"}
          } ]]
          signs = {
            --[[ add          = {hl = '#140', text = '│', numhl='#140'   , linehl='#140'},
            change       = {hl = '#140', text = '│', numhl='#140', linehl='#140'}, ]]
            -- add          = {hl = 'GitSignsAdd', text = '│', numhl='#140'   , linehl='#140'},
            add          = {hl = 'GitSignsAdd'   , text = '│', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
            change       = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
            -- change       = {hl = '#140', text = '│', numhl='#140', linehl='#140'},
            delete       = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
            topdelete    = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
            changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
          }
        }
      end
    }
    use 'sindrets/diffview.nvim'
    use {
      "TimUntersberger/neogit",
      requires = {
        'nvim-lua/plenary.nvim',
        'sindrets/diffview.nvim'
      }
    }

    -- -- Markdown
    -- use {"tpope/vim-markdown", ft = "markdown"}
    -- use {"nelstrom/vim-markdown-folding", ft = "markdown"}
    -- use {"dhruvasagar/vim-table-mode"}
    use {
      "iamcco/markdown-preview.nvim",
      run = "cd app && npm install"
    }
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
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require "colorizer".setup()
      end
    }
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
    use {
      'nvim-treesitter/nvim-treesitter',
      -- event = "BufRead",
      run = ':TSUpdate'
    }

    -- is this causing errors in the checkhealth. Looks like it's causing slowness in projects
    -- use {"nvim-treesitter/nvim-treesitter-angular"}
    -- get this working on install
    use {"nvim-treesitter/playground"}

    -- snippets
    -- might remove snippets
    -- use {"norcalli/snippets.nvim"}
    -- vsnip allows using any vscode snippet extension and it will be added to the vsnip list
    -- use {"hrsh7th/vim-vsnip"}
    -- use {"hrsh7th/vim-vsnip-integ"}
    use {"johnpapa/vscode-angular-snippets"}
    use {"xabikos/vscode-javascript"}
    use {"sidthesloth92/vsc_html5_boilerplate"}
    --[[ use {"Shougo/deoplete.nvim", run = "remote#host#UpdateRemotePlugins()"}
    use {"shougo/deoplete-lsp"} ]]

    -- lsp
    -- might not need completion. using compe
    -- use {"nvim-lua/completion-nvim"}
    -- compe is deprecated. Now cmp
    -- use {"hrsh7th/nvim-compe"}
    -- cmp is newer version of compe
    -- Install nvim-cmp, and buffer source as a dependency
    use { "hrsh7th/cmp-vsnip" }
    use {
      "hrsh7th/nvim-cmp",
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        -- "hrsh7th/cmp-vsnip",
        "hrsh7th/vim-vsnip",
        "hrsh7th/vim-vsnip-integ",
      }
    }
    use {"onsails/lspkind-nvim"}
    -- use {"kosayoda/nvim-lightbulb"}
    use {"neovim/nvim-lspconfig"}
    use {"glepnir/lspsaga.nvim"}

    -- telescope advanced search
    use {"nvim-lua/popup.nvim"}
    use {"nvim-lua/plenary.nvim"}
    -- use {"nvim-telescope/telescope.nvim"}
    use {
      "nvim-telescope/telescope.nvim",
      requires = {
        "nvim-lua/plenary.nvim",
        {
          "nvim-telescope/telescope-fzf-native.nvim",
          run = "make",
        },
      }
    }
    use {"nvim-telescope/telescope-github.nvim"}
    -- packer is causing the PackerUpdate issues
    use {"nvim-telescope/telescope-packer.nvim"}
    use {"nvim-telescope/telescope-node-modules.nvim"}

    use {
      'pwntester/octo.nvim',
      requires = {
        "nvim-telescope/telescope.nvim",
      },
      config = function()
        require "octo".setup()
      end
    }

    -- autopairs
    use {"windwp/nvim-autopairs"}

    -- autoclosing for html
    -- use {"windwp/nvim-ts-autotag"}

    -- start menu
    use {"mhinz/vim-startify"}
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
    use {
      "kyazdani42/nvim-web-devicons",
      config = function()
        require "nvim-web-devicons".setup(
          {
            overrides = {
              git = {icon = ""},
              js = {icon = ""},
              vim = {icon = ""},
              css = {icon = ""},
              html = {icon = ""},
              json = {icon = ""},
              md = {icon = ""},
              sql = {icon = ""}
            }
          }
        )
      end
    }
    -- Lua
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require "trouble".setup()
      end
          --[[ {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
          } ]]
        --[[ )
      end ]]
    }


  end)
