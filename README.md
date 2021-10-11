# lua-config
config and setup for nvim with Lua

***Check List***
- Install zsh and oh-my-zsh (not required)
- Install latest nightly build of neovim (having this will allow nvim to search for and execute your init.lua file at file load)
- Install ripgrep for telescope
- Install a previewer syntax tool like bat (although this one is deprecated according to docs) if you want syntax highlighting in file finder preview
- Install web-dev-icons for file icons
- If you don't have a lua package manager, this config uses Packer. It will install it automatically when running the file if it can't find it in the path
- Check this wiki for setting up the lua lsp. Getting this set up may also fix some things to allow tree-sitter to work as well https://github.com/sumneko/lua-language-server/wiki/Build-and-Run-(Standalone)
  - May also need to run commands like `npm i -g tree-sitter-cli` (make sure npm is up to date as it might error if not) as well as installing other npm packages needed to run like `npm i -g typescript-language-server`. Most of the lsp servers will list a package to install
  - You may need to run some tree-sitter commands to get all of the language parsers installed `:TSUpdate <language or can use 'all'>`, `:TSInstallFromGrammar <language or all>`, or `:TSInstall <language or all>` for tree-sitter. Run `:checkhealth` to see the language parsers set up and their statuses.
  - Running :LspInfo should give some statuses for language servers being run while inside files. They should be active when in the right file. If not, look at `~/.cache/nvim/lsp.log` for error troubleshooting. The neovim/nvim-lsp repo will also have a `config.MD` file to reference and find the language server you need to install and how it can be configured.
- If there is trouble running the rebuild command when setting up the lua-language-server, this comment and this thread should help https://gist.github.com/application2000/73fd6f4bf1be6600a2cf9f56315a2d91#gistcomment-3311157

***Notes***
- Lots of credit to mhartington as this config is generally based off his
- This config is generally focused for workflows using typescript and likely angular
