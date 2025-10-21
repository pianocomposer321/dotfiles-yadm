return {
  {
    "nvim-neorg/neorg",
    lazy = false,
    build = ":Neorg sync-parsers",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- {
      --   "juniorsundar/neorg-extras",
      --   dev = true,
      --   -- tag = "*" -- Always a safe bet to track current latest release
      -- },
      -- FOR Neorg-Roam Features
      --- OPTION 1: Telescope
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim" -- Required as part of Telescope installation
    },
    config = function()
      require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
                todos = "~/Documents/neorg_todos",
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
          -- ["external.many-mans"] = {
          --   config = {
          --     metadata_fold = true, -- If want @data property ... @end to fold
          --     code_fold = true, -- If want @code ... @end to fold
          --   }
          -- },
          -- OPTIONAL
          -- ["external.agenda"] = {
          --   config = {
          --     workspace = "todos",
          --   }
          -- },
          -- ["external.roam"] = {
          --   config = {
          --     fuzzy_finder = "Telescope", -- OR "Fzf" ... Defaults to "Telescope"
          --     fuzzy_backlinks = false, -- Set to "true" for backlinks in fuzzy finder instead of buffer
          --     roam_base_directory = "", -- Directory in current workspace to store roam nodes
          --     node_name_randomiser = false, -- Tokenise node name suffix for more randomisation
          --     node_name_snake_case = false, -- snake_case the names if node_name_randomiser = false
          --   }
          -- },
        },
      }
      -- require("neorg.core").modules.get_module("core.dirman").set_workspace("todos")
    end,
  },
}
