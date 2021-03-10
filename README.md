# lua-config
config and setup for nvim with Lua

***Check List***
- Install zsh and oh-my-zsh (not required)
- Install latest nightly build of neovim (having this will allow nvim to search for and execute your init.lua file at file load)
- Install ripgrep for telescope
- Install a previewer syntax tool like bat (although this one is deprecated according to docs) if you want syntax highlighting in file finder preview
- Install web-dev-icons for file icons
- If you don't have a lua package manager, this config uses Packer. It will install it automatically when running the file if it can't find it in the path
- May also need to run commands like :TSUpdate or :TSInstall for tree-sitter and npm i -g typescript-language-server for lsp. Running :LspInfo should give some statuses for language servers being run while inside files

***Notes***
- Lots of credit to mhartington as this config is generally based off his
- This config is generally focused for workflows using typescript and likely angular
