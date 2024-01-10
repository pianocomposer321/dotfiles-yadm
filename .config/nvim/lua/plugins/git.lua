return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("gitsigns").setup {}
    end
  },
  {
    "tpope/vim-fugitive",
    -- lazy = false,
    event = "VeryLazy",
    init = function()
      vim.keymap.set("n", "<LEADER>gg", vim.cmd.G)
      vim.keymap.set("n", "<LEADER>gc", function() vim.cmd.G("commit") end)
      vim.keymap.set("n", "<LEADER>gp", function() vim.cmd.G("push") end)
      vim.keymap.set("n", "<LEADER>g<SPACE>", ":Git ")
    end
  }
}
