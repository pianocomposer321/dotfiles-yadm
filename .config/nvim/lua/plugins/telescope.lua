return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = "nvim-lua/plenary.nvim",
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
    config = {
      defaults = {
        mappings = {
          i = {
            ["<esc>"] = "close"
          }
        }
      }
    }
  },
  { "stevearc/dressing.nvim", event = "VeryLazy" },
}
