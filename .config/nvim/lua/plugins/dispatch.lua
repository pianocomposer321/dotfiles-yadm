return {
  {
    "tpope/vim-dispatch",
    enabled = false,
    event = "VeryLazy"
  },
  {
    "pianocomposer321/dispatch-overseer.nvim",
    dependencies = { "stevearc/overseer.nvim" },
    dev = true,
    event = "VeryLazy",
    config = function()
      require("dispatch-overseer").setup {
        create_mappings = true,
        additional_components = { "user.track_history" },
      }
    end,
  },
}
