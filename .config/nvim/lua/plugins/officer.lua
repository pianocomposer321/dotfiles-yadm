return {
  "pianocomposer321/officer.nvim",
  dependencies = { "stevearc/overseer.nvim" },
  -- dev = true,
  event = "VeryLazy",
  config = function()
    require("officer").setup {
      create_mappings = true,
      components = { "user.track_history" },
    }
  end,
}
