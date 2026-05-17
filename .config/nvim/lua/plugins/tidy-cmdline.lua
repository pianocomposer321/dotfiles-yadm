return {
  "rachartier/tiny-cmdline.nvim",
  -- event = "VeryLazy",
  -- enabled = false,
  lazy = false,

  config = function()
    vim.o.cmdheight = 0
    vim.api.nvim_set_hl(0, "TinyCmdlineBorder", { fg = 6054768, bg = 2632756 })
    require("tiny-cmdline").setup {
      position = {
        x = "50%",  -- horizontal: "0%" = left, "50%" = center, "100%" = right
        y = "20%",  -- vertical:   "0%" = top,  "50%" = center, "100%" = bottom
      },
    }
  end,
}
