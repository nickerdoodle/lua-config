  --
  -- opt = true,
  -- cmd = { "DocsViewToggle" },
  -- config = function()
    -- require("docs-view").setup {
    require("nvim-docs-view").setup {
      position = "right",
      width = vim.api.nvim_get_option("columns") / 3,
    }
  -- end
