require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})
--TODO: find out if we need autopairs still

-- cmp deprecated this. I think it can do it on it's own now
--
-- you need setup cmp first put this after cmp.setup()
-- require("nvim-autopairs.completion.cmp").setup({
--   map_cr = true, --  map <CR> on insert mode
--   map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
--   auto_select = true, -- automatically select the first item
--   insert = false, -- use insert confirm behavior instead of replace
--   map_char = { -- modifies the function or method delimiter by filetypes
--     all = '(',
--     tex = '{'
--   }
-- })
