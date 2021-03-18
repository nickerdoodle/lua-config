" Automatically generated packer.nvim plugin loader code

if !has('nvim-0.5')
  echohl WarningMsg
  echom "Invalid Neovim version for packer.nvim!"
  echohl None
  finish
endif

packadd packer.nvim

try

lua << END
local package_path_str = "/home/nick/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/nick/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/nick/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/nick/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/nick/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s))
  if not success then
    print('Error running ' .. component .. ' for ' .. name)
    error(result)
  end
  return result
end

_G.packer_plugins = {
  SimpylFold = {
    loaded = false,
    needs_bufread = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/opt/SimpylFold"
  },
  ["caw.vim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/caw.vim"
  },
  ["completion-nvim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/completion-nvim"
  },
  ["context_filetype.vim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/context_filetype.vim"
  },
  delimitMate = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/delimitMate"
  },
  ["deoplete-lsp"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/deoplete-lsp"
  },
  ["deoplete.nvim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/deoplete.nvim"
  },
  ["editorconfig-vim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/editorconfig-vim"
  },
  ["emmet-vim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/emmet-vim"
  },
  ["formatter.nvim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/formatter.nvim"
  },
  ["github-light.vim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/github-light.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n�\2\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\2B\0\2\1K\0\1\0\nsigns\1\0\0\17changedelete\1\0\2\ttext\6~\ahl\26GitGutterChangeDelete\14topdelete\1\0\2\ttext\b‾\ahl\20GitGutterDelete\vdelete\1\0\2\ttext\6_\ahl\20GitGutterDelete\vchange\1\0\2\ttext\b│\ahl\20GitGutterChange\badd\1\0\0\1\0\2\ttext\b│\ahl\17GitGutterAdd\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/gitsigns.nvim"
  },
  ["glow-in-the-dark-gucci-shark-bites-vim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/glow-in-the-dark-gucci-shark-bites-vim"
  },
  gruvbox = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/gruvbox"
  },
  ["html5.vim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/html5.vim"
  },
  indentLine = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/indentLine"
  },
  ["lspkind-nvim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim"
  },
  neogit = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/neogit"
  },
  nerdtree = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/nerdtree"
  },
  ["nerdtree-git-plugin"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/nerdtree-git-plugin"
  },
  ["night-owl-vim-theme"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/night-owl-vim-theme"
  },
  ["nvim-bufdel"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/nvim-bufdel"
  },
  ["nvim-bufferline.lua"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/nvim-bufferline.lua"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/nvim-compe"
  },
  ["nvim-lightbulb"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/nvim-lightbulb"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/nvim-tree.lua"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n�\2\0\0\5\0\22\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\20\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\3=\3\21\2B\0\2\1K\0\1\0\14overrides\1\0\0\bsql\1\0\1\ticon\b\amd\1\0\1\ticon\b\tjson\1\0\1\ticon\b\thtml\1\0\1\ticon\b\bcss\1\0\1\ticon\b\bvim\1\0\1\ticon\b\ajs\1\0\1\ticon\b\bgit\1\0\0\1\0\1\ticon\b\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/nvim-web-devicons"
  },
  ["oceanic-next"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/oceanic-next"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/popup.nvim"
  },
  ["rust.vim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/rust.vim"
  },
  ["snippets.nvim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/snippets.nvim"
  },
  ["swift.vim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/swift.vim"
  },
  ["switch.vim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/switch.vim"
  },
  ["telescope-github.nvim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/telescope-github.nvim"
  },
  ["telescope-node-modules.nvim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/telescope-node-modules.nvim"
  },
  ["telescope-packer.nvim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/telescope-packer.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/telescope.nvim"
  },
  ["vim-PairTools"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-PairTools"
  },
  ["vim-colors-synthwave"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-colors-synthwave"
  },
  ["vim-colors-xcode"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-colors-xcode"
  },
  ["vim-css3-syntax"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-css3-syntax"
  },
  ["vim-diff-fold"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-diff-fold"
  },
  ["vim-easy-align"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-easy-align"
  },
  ["vim-equinusocio-material"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-equinusocio-material"
  },
  ["vim-folds"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-folds"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-fugitive"
  },
  ["vim-html-escape"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-html-escape"
  },
  ["vim-jsdoc"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-jsdoc"
  },
  ["vim-json"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-json"
  },
  ["vim-jsx-pretty"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-jsx-pretty"
  },
  ["vim-lua"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-lua"
  },
  ["vim-markdown"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/opt/vim-markdown"
  },
  ["vim-markdown-folding"] = {
    loaded = false,
    needs_bufread = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/opt/vim-markdown-folding"
  },
  ["vim-mdx-js"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-mdx-js"
  },
  ["vim-monokai-tasty"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-monokai-tasty"
  },
  ["vim-nightfly-guicolors"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-nightfly-guicolors"
  },
  ["vim-racer"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-racer"
  },
  ["vim-repeat"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-repeat"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-rhubarb"
  },
  ["vim-sayonara"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-sayonara"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-surround"
  },
  ["vim-svelte-plugin"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-svelte-plugin"
  },
  ["vim-table-mode"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-table-mode"
  },
  ["vim-textobj-user"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-textobj-user"
  },
  ["vim-textobj-xmlattr"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-textobj-xmlattr"
  },
  ["vim-tmux"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-tmux"
  },
  ["vim-tmux-navigator"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-tmux-navigator"
  },
  ["vim-unimpaired"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-unimpaired"
  },
  ["vim-visual-multi"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-visual-multi"
  },
  ["vim-vue"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-vue"
  },
  ["vim-xcode"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-xcode"
  },
  ["vim-yaml-folds"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vim-yaml-folds"
  },
  vison = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vison"
  },
  ["vitality.vim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/vitality.vim"
  },
  ["yajs.vim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/yajs.vim"
  },
  yanil = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/yanil"
  },
  ["yats.vim"] = {
    loaded = true,
    path = "/home/nick/.local/share/nvim/site/pack/packer/start/yats.vim"
  }
}

-- Config for: nvim-web-devicons
try_loadstring("\27LJ\2\n�\2\0\0\5\0\22\0\0256\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\20\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\0035\4\14\0=\4\15\0035\4\16\0=\4\17\0035\4\18\0=\4\19\3=\3\21\2B\0\2\1K\0\1\0\14overrides\1\0\0\bsql\1\0\1\ticon\b\amd\1\0\1\ticon\b\tjson\1\0\1\ticon\b\thtml\1\0\1\ticon\b\bcss\1\0\1\ticon\b\bvim\1\0\1\ticon\b\ajs\1\0\1\ticon\b\bgit\1\0\0\1\0\1\ticon\b\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
-- Config for: gitsigns.nvim
try_loadstring("\27LJ\2\n�\2\0\0\5\0\16\0\0196\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\14\0005\3\4\0005\4\3\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0035\4\f\0=\4\r\3=\3\15\2B\0\2\1K\0\1\0\nsigns\1\0\0\17changedelete\1\0\2\ttext\6~\ahl\26GitGutterChangeDelete\14topdelete\1\0\2\ttext\b‾\ahl\20GitGutterDelete\vdelete\1\0\2\ttext\6_\ahl\20GitGutterDelete\vchange\1\0\2\ttext\b│\ahl\20GitGutterChange\badd\1\0\0\1\0\2\ttext\b│\ahl\17GitGutterAdd\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
-- Config for: nvim-colorizer.lua
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
vim.cmd [[augroup packer_load_aucmds]]
vim.cmd [[au!]]
  -- Filetype lazy-loads
vim.cmd [[au FileType python ++once lua require("packer.load")({'SimpylFold'}, { ft = "python" }, _G.packer_plugins)]]
vim.cmd [[au FileType markdown ++once lua require("packer.load")({'vim-markdown-folding', 'vim-markdown'}, { ft = "markdown" }, _G.packer_plugins)]]
vim.cmd("augroup END")
vim.cmd [[augroup filetypedetect]]
vim.cmd [[source /home/nick/.local/share/nvim/site/pack/packer/opt/vim-markdown/ftdetect/markdown.vim]]
vim.cmd("augroup END")
END

catch
  echohl ErrorMsg
  echom "Error in packer_compiled: " .. v:exception
  echom "Please check your config for correctness"
  echohl None
endtry
