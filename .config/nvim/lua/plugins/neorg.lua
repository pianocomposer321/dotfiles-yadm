return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
                morning_journal = "~/Documents/journal",
              },
            },
          },
          ["core.journal"] = {
            config = {
              workspace = "morning_journal",
            },
          },
          ["core.summary"] = {},
          ["external.query-test"] = {},
        },
      }
    end,
  },
}
