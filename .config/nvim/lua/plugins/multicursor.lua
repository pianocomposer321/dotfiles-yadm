return {
  "jake-stewart/multicursor.nvim",
  event = "VeryLazy",
  config = function()
    local mc = require("multicursor-nvim")

    mc.setup({
      -- set to true if you want multicursor undo history
      -- to clear when clearing cursors
      shallowUndo = false,

      -- set to empty table to disable signs
      signs = { " ┆"," │", " ┃" },
    })

    vim.keymap.set("n", "<C-k>", function() mc.addCursor("k") end)
    vim.keymap.set("n", "<C-j>", function() mc.addCursor("j") end)

    vim.keymap.set("n", "<esc>", function()
      if not mc.cursorsEnabled() then
        mc.enableCursors()
      elseif mc.hasCursors() then
        mc.clearCursors()
      -- else
      --   -- Default <esc> handler.
      end
    end)

  end,
}
