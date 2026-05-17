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

    vim.keymap.set({"n", "x"}, "<leader>n", function() mc.matchAddCursor(1) end)
    vim.keymap.set({"n", "x"}, "<leader>s", function() mc.matchSkipCursor(1) end)
    vim.keymap.set({"n", "x"}, "<leader>N", function() mc.matchAddCursor(-1) end)
    vim.keymap.set({"n", "x"}, "<leader>S", function() mc.matchSkipCursor(-1) end)

    -- Pressing `gaip` will add a cursor on each line of a paragraph.
    -- Can also be used to add cursor for each line of visual selection.
    vim.keymap.set({"n", "x"}, "ga", mc.addCursorOperator)

    -- Split visual selections by regex.
    vim.keymap.set("x", "S", mc.splitCursors)

    -- match new cursors within visual selections by regex.
    vim.keymap.set("x", "M", mc.matchCursors)

    -- bring back cursors if you accidentally clear them
    vim.keymap.set("n", "<leader>gv", mc.restoreCursors)

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
