return {
  "folke/noice.nvim",
  -- enabled = false,

  event = "VeryLazy",
  -- enabled = false,
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify",
  },
  -- HERE -> config to opts
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      signature = { enabled = false },
    },
    -- you can enable a preset for easier configuration
    cmdline = { enabled = false },
    popupmenu = { enabled = false },
    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      command_palette = false, -- position the cmdline and popupmenu together
      long_message_to_split = false, -- long messages will be sent to a split
      inc_rename = false, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    notify = { enabled = false },
    -- messages = { enabled = false },
    messages = {
      enabled = true,  -- keep enabled for search_count
      view_search = "virtualtext", -- show search count as virtual text
      view = false,    -- disable other message views
      view_error = false,
      view_warn = false,
      view_history = false,
    },
    routes = {
      {
        filter = {
          event = "msg_show",
          kind = "",
          find = "written",
        },
        opts = { skip = true },
      },
    },
    -- messages = {
    --   view = "messages",
    --   view_search = "virtualtext",
    -- }
  }
}
