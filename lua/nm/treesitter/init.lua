local ts = require "nvim-treesitter.configs"
ts.setup {
  context_commentstring = {enable = true},
  ensure_installed = "all",
  -- ensure_installed = "maintained",
  ignore_install = { "haskell" }, -- ignore installing
  highlight = {
    -- setting this to true definitely changes highlighting and possibly speed
    enable = true,
    use_languagetree = true
  },
  indent = {
    enable = false
  },
  autotag = {
    enable = true
  },
  angular = {
    enable = true
  }
}

-- For the html and xml autotag from nvim-ts-autotag
require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true,
  }
}
