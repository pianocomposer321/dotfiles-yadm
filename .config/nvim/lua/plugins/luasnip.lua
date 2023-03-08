return {
  "L3MON4D3/LuaSnip",
  init = function()
    vim.keymap.set({"i", "s"}, "<C-j>", function() require("luasnip").jump(1) end)
    vim.keymap.set({"i", "s"}, "<C-k>", function() require("luasnip").jump(-1) end)
  end,
}
