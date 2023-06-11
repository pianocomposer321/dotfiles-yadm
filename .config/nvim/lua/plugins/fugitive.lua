return {
  "tpope/vim-fugitive",
  -- lazy = false,
  event = "VeryLazy",
  init = function()
    vim.keymap.set("n", "<LEADER>gg", vim.cmd.G)
    vim.keymap.set("n", "<LEADER>gc", function() vim.cmd.G("commit") end)
  end
}
