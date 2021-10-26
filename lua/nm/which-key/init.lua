local which_key = require("which-key")

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ...
      motions = false, -- adds help for motions
      text_objects = false, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
    spelling = { enabled = true, suggestions = 20 }, -- use which-key for spelling hints
  },
  icons = {
    breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
    separator = "➜", -- symbol used between a key and it's label
    group = "+", -- symbol prepended to a group
  },
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
  },
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
}

local opts = {
  mode = "n", -- NORMAL mode
  -- the prefix is prepended to every mapping part of `mappings`
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
-- for i = 1, 9 do
--   M.map("n", "<leader>" .. i, ':lua require"bufferline".go_to_buffer(' .. i .. ")<CR>")
--   M.map("t", "<leader>" .. i, '<C-\\><C-n>:lua require"bufferline".go_to_buffer(' .. i .. ")<CR>")
-- end
  b = {
    name = "Buffers",
    -- Confirm delete is right
    d = { ":BufDel<cr>", "Delete Buffer"},
    l = { "<cmd> Telescope buffers<cr>", "Buffer List" },
    n = { "<cmd>bnext<cr>", "Next Buffer"},
    p = { "<cmd>bprevious<cr>", "Previous Buffer"},
  },

  c = { "<cmd>Telescope colors<cr>", "Colorschemes" },

  f = {
    name = "Files", -- optional group name
    f = { "<cmd>Telescope find_files<cr>", "Find File" }, -- create a binding with label
    h = { "<cmd>lua require('nm.telescope').find_files()<cr>", "Find File" }, -- create a binding with label
    g = { "<cmd>Telescope git_files<cr>", "Git Files" }, -- create a binding with label
    i = { "<cmd>lua require('nm.telescope').git_files()<cr>", "Git Files (Custom)" }, -- create a binding with label
    o = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" }, -- create a binding with label
    s = { "<cmd>Telescope live_grep<cr>", "Live Grep" }, -- create a binding with label

    n = { "New File" }, -- just a label. don't create any mapping
    e = "Edit File", -- same as above
    -- ["1"] = "which_key_ignore",  -- special label to hide it in the popup
    -- b = { function() print("bar") end, "Foobar" } -- you can also pass functions!
  },

  g = {
    name = "Git",
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      "Undo Stage Hunk",
    },
    o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
    b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
    c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
    C = {
      "<cmd>Telescope git_bcommits<cr>",
      "Checkout commit(for current file)",
    },
    d = {
      "<cmd>Gitsigns diffthis HEAD<cr>",
      "Git Diff",
    },
  },

  h = {
    name = "Help",
    t = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
    k = { "<cmd>Telescope keymaps<cr>", "Mappings" },
  },

  l = {
    name = "Lsp",
    a = { "<cmd>lua vim.lsp.codelens.refresh()<cr>", "Refresh Codelens"},
    c = { "<cmd>lua vim.lsp.codelens.run()<cr>", "Run Codelens"},
    d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Document Diagnostics" },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
    i = { "<cmd>LspInfo<cr>", "Info" },
    I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
    j = {
      "<cmd>lua vim.lsp.diagnostic.goto_next({popup_opts = {border = 'single'}})<cr>",
      "Next Diagnostic",
    },
    k = {
      "<cmd>lua vim.lsp.diagnostic.goto_prev({popup_opts = {border = 'single'}})<cr>",
      "Prev Diagnostic",
    },
    l = { "<cmd>Trouble loclist<cr>", "Loc List" },
    m = { "<cmd>Trouble quickfix<cr>", "Quick Fix List" },
    o = { "<cmd>lua require('trouble').refresh({ open_folds = true })<cr>", "Trouble open all folds" },
    q = { "<cmd>Telescope lsp_code_actions<cr>", "Code Actions" },
    r = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
    t = { "<cmd>Trouble<cr>", "Trouble Plugin" },
    w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Workspace Diagnostics" },
    z = { "<cmd>lua require('trouble').refresh({ close_folds = true })<cr>", "Trouble close all folds" },
  },

  n = {
    name = "Nvim",
    f = { "<cmd>lua require('nm.telescope').nvim_files()<cr>", "Config Files" },
  },

  p = {
    name = "Packer",
    c = { "<cmd>PackerClean<cr>", "Clean" },
    h = { "<cmd>PackerStatus<cr>", "Status" },
    s = { "<cmd>PackerSync<cr>", "Sync" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
  },

  -- TODO: update these grep calls to use custom nm module to pass in the window settings I want for these results
  s = {
    name = "Search",
    p = { "<cmd>lua require('telescope.builtin').live_grep{ cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1] }<cr>", "Grep project"},
    a = { "<cmd>lua require('telescope.builtin').grep_string{ cwd = vim.fn.systemlist('git rev-parse --show-toplevel')[1] }<cr>", "Find all occurrences (project)"},
  },

  S = {
    name = "Surround",
    -- TODO: put this in its own 'surround' key. Add the other surround bindings. Use :Telescope keymaps, type s to see more
    a = { "<cmd>set operatorfunc=SurroundAddOperatorMode<cr> g@", "Add" }, -- create a binding with label
    d = { "<cmd>lua require('surround').surround_delete()<cr>", "Delete" }, -- create a binding with label
    r = { "<cmd>lua require('surround').surround_replace()<cr>", "Replace" }, -- create a binding with label
    w = { "<cmd>set operatorfunc=SurroundAddOperatorMode<cr> g@iw", "Word" }, -- create a binding with label
  },

  t = {
    name = "Terminal",
    f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm direction=vertical<cr>", "Vertical" },

  }

}

which_key.setup(setup)

-- TODO: make normal mappings and vmappings/vopts
which_key.register(mappings, opts)

