return {
  "folke/zen-mode.nvim",
  event = "VeryLazy",
  config = true,
  opts = {
    window = {
      width = 82, -- 80 chars + signcolumn
      -- options = {
      --   winbar = "",
      -- }
    },
    on_open = function()
      vim.opt_local.winbar = ""
    end,
  },
}
