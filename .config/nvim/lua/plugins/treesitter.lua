return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- event = "BufReadPre",
    event = "VeryLazy",
    -- lazy = false,
    config = function()
---@diagnostic disable-next-line: missing-fields
      require'nvim-treesitter.configs'.setup {
        auto_install = true,
        ensure_installed = {
          "lua",
          "norg",
          -- "org",
          "rust",
          "toml",
        },
        indent = {
          enable = { "svelte" },
        },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "org" },
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<A-o>",
            node_incremental = "<A-o>",
            node_decremental = "<A-i>",
          }
        },
        playground = {
          enable = true,
          disable = {},
          updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
          persist_queries = false, -- Whether the query persists across vim sessions
          keybindings = {
            toggle_query_editor = 'o',
            toggle_hl_groups = 'i',
            toggle_injected_languages = 't',
            toggle_anonymous_nodes = 'a',
            toggle_language_display = 'I',
            focus_language = 'f',
            unfocus_language = 'F',
            update = 'R',
            goto_node = '<cr>',
            show_help = '?',
          },
        },
        autotag = {
          enable = true
        },
      }
    end,
    run = ":TSUpdate",
  },
  {
    "Wansmer/treesj",
    dependencies = "nvim-treesitter/nvim-treesitter",
    init = function()
      vim.keymap.set("n", "<A-j>", function() require("treesj").join() end)
      vim.keymap.set("n", "<A-k>", function() require("treesj").split() end)
    end,
    config = function()
      require("treesj").setup {
        use_default_keys = false,
      }
    end,
  },
  {
    "nvim-treesitter/playground",
    -- event = "BufReadPre",
    lazy = false,
    dependencies = "nvim-treesitter/nvim-treesitter",
  },
  {
    "windwp/nvim-ts-autotag",
    event = "VeryLazy",
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufEnter",
    config = function()
      require('treesitter-context').setup {
        max_lines = 3,
        mode = "topline",
      }
    end,
  },
}
