return {
  {
    "nvim-neorg/neorg",
    ft = "norg",
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                -- default = "~/Documents/neorg",
                example_gtd = "~/git/example_workspaces/gtd",
              }
            }
          },
          ["core.concealer"] = {},
          -- ["core.gtd.base"] = {
          --   config = {
          --     workspace = "example_gtd",
          --   },
          -- },
        }
      }
    end,
  },
}
