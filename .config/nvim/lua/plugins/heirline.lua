return {
  "rebelot/heirline.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons"
  },
  event = "VeryLazy",
  -- enabled = false,
  init = function()
    vim.cmd("set statusline=\\ ")
  end,
  config = function()
    -- local conditions = require("heirline.conditions")
    local utils = require("heirline.utils")
    local heirline = require("heirline")
    local widgets = require("user.heirline_widgets")

    local colors = {
      bright_bg = utils.get_highlight("Folded").bg,
      bright_fg = utils.get_highlight("Folded").fg,
      red = utils.get_highlight("DiagnosticError").fg,
      dark_red = utils.get_highlight("DiffDelete").bg,
      green = utils.get_highlight("String").fg,
      blue = utils.get_highlight("Function").fg,
      gray = utils.get_highlight("NonText").fg,
      orange = utils.get_highlight("Constant").fg,
      purple = utils.get_highlight("Statement").fg,
      cyan = utils.get_highlight("Special").fg,
      diag_warn = utils.get_highlight("DiagnosticWarn").fg,
      diag_error = utils.get_highlight("DiagnosticError").fg,
      diag_hint = utils.get_highlight("DiagnosticHint").fg,
      diag_info = utils.get_highlight("DiagnosticInfo").fg,
      bg = utils.get_highlight("LineNr").fg,
      git_del = utils.get_highlight("diffRemoved").fg,
      git_add = utils.get_highlight("diffAdded").fg,
      git_change = utils.get_highlight("diffChanged").fg,
    }
    heirline.load_colors(colors)

    local statusline = {
      widgets.ViMode, widgets.Space,
      widgets.FileName, widgets.Space, widgets.FileModified, widgets.Space,
      widgets.LSPActive, widgets.Space, widgets.Space, widgets.Git,

      widgets.Align,

      widgets.Diagnostics, widgets.Space, widgets.Ruler,
      -- hl = { bg = colors.bg },
    }

    heirline.setup {statusline = statusline}
  end
}
