local vim = vim
local telescope = require("telescope")
local builtIn = require("telescope.builtin")
local actions = require("telescope.actions")
local M = {}

telescope.load_extension("gh")
-- commented this out. an update to repo might mean i don't need it anymore
-- telescope.load_extension("node_modules")
telescope.load_extension("packer")

telescope.setup {
  defaults = {
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        -- ["<CR>"] = actions.goto_file_selection_edit,
        ["<CR>"] = actions.select_default + actions.center,
        ["<Tab>"] = actions.toggle_selection
      }
    },
-- file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
--     grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
--     qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,
    -- Developer configurations: Not meant for general override
    -- buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}
local function generateOpts(opts)
  local common_opts = {
    layout_strategy = "horizontal",
    sorting_strategy = "ascending",
    results_title = false,
    preview_title = "Preview",
    layout_config = {
      height = 25
    -- width = 80,
    },
    -- previewer = false,
    borderchars = {
      {"─","│", "─", "│", "╭", "╮", "╯", "╰"},
      prompt = {"─", "│", " ", "│", "╭", "╮", "│", "│"},
      results = {"─", "│", "─", "│", "├", "┤", "╯", "╰"},
      preview = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"}
    }
  }
  return vim.tbl_extend("force", opts, common_opts)
end
function M.colors()
  local opts = generateOpts({})
  builtIn.colorscheme(opts)
end
function M.find_files()
  local cmn_opts = generateOpts({})
  cmn_opts.find_command = {"rg", "--files", "-L", "--glob", "!.git"}
  builtIn.find_files(cmn_opts)
end
function M.help_tags()
  local opts = generateOpts({})
  builtIn.help_tags(opts)
end
return M
