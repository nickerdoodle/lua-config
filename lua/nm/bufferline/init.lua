local colors = require "nm.colors"
require('bufferline').setup {
  options = {
    view = "default",
    numbers = function(opts)
      -- return string.format('%s.)%s.)', opts.ordinal, opts.id)
      return string.format('%s.', opts.ordinal)
    end,
    buffer_close_icon = "",
    modified_icon = "",
    close_icon = "",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 18,
    max_prefix_length = 15 ,
    show_buffer_close_icons = true,
    show_line_diagnostics = true,
    persist_buffer_sort = true,
    separator_style = { '', '' },
    enforce_regular_tabs = false,
    always_show_bufferline = true
  },
  highlights = {
    modified           = { guifg = colors.green, guibg = "#0F1E28" },
    modified_visible   = { guifg = "#3C706F", guibg = "#16242E" },
    modified_selected  = { guifg = colors.cyan, guibg = "#142832" },

    fill               = { guibg = "#0F1E28" },
    background         = { guibg = "#0F1E28", guifg = colors.base04 },

    tab                = { guibg = "#0F1E28", guifg = colors.base01 },
    tab_selected       = { guibg = "#142832" },
    tab_close          = { guibg = "#0F1E28" },

    buffer_visible     = { guibg = "#16242E"},
    buffer_selected    = { guibg = "#142832", guifg = colors.whte, gui   = "" },

    indicator_selected = { guifg = colors.cyan, guibg = "#142832" },

    separator          = { guibg = "#62b3b2" },
    separator_selected = { guifg = colors.cyan,  guibg = "#142832" },
    separator_visible  = { guibg = colors.cyan },

    duplicate          = { guibg = "#0F1E28", guifg = colors.base04, gui   = "" },
    duplicate_selected = { guibg = "#142832", gui   = "",guifg=colors.white },
    duplicate_visible  = { guibg = "#16242E", gui   = "",  },
  }
}
