# lua-config
config and setup for nvim with Lua

***Check List***
- Install zsh and oh-my-zsh (not required)
- Install latest nightly build of neovim (having this will allow nvim to search for and execute your init.lua file at file load)
- Install ripgrep for telescope
- Install a previewer syntax tool like bat (although this one is deprecated according to docs) if you want syntax highlighting in file finder preview
- Install web-dev-icons for file icons
- If you don't have a lua package manager, this config uses Packer. It will install it automatically when running the file if it can't find it in the path
- May also need to run commands like npm i -g tree-sitter-cli (make sure npm is up to date as it might error if not) and :TSUpdate or :TSInstall for tree-sitter and npm i -g typescript-language-server for lsp. Running :LspInfo should give some statuses for language servers being run while inside files. They should be active when in the right file. If not, look at ~/.cache/nvim/lsp.log for error troubleshooting. The neovim/nvim-lsp repo will also have a config.MD file to reference and find the language server you need to install and how it can be configured.
- If there is trouble running the rebuild command when setting up the lua-language-server, this comment and this thread should help https://gist.github.com/application2000/73fd6f4bf1be6600a2cf9f56315a2d91#gistcomment-3311157

***Notes***
- Lots of credit to mhartington as this config is generally based off his
- This config is generally focused for workflows using typescript and likely angular
