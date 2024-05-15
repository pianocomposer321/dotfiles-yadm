return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = 'make' },
    },
    init = function()
      vim.keymap.set("n", "<LEADER>td", function() require("telescope.builtin").diagnostics() end)
      vim.keymap.set("n", "<LEADER>tf", function() require("telescope.builtin").find_files() end)
      vim.keymap.set("n", "<LEADER>tb", function() require("telescope.builtin").buffers() end)

      --- Shortcuts for frequently used mappings
      vim.keymap.set("n", "<LEADER>f", function() require("telescope.builtin").find_files() end)
      vim.keymap.set("n", "<LEADER>b", function() require("telescope.builtin").buffers() end)

      vim.keymap.set("n", "<LEADER>ls", function() require("telescope.builtin").lsp_document_symbols() end)
      vim.keymap.set("n", "<LEADER>lw", function() require("telescope.builtin").lsp_workspace_symbols() end)
    end,
    config = function()
      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = "close"
            }
          }
        },
        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          }
        },
      }
      require("telescope").load_extension("fzf")
    end
  },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
}
