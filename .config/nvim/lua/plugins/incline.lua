return {
  'b0o/incline.nvim',
  init = function()
    vim.keymap.set("n", "<leader>it", function() require("incline").toggle() end)
  end,
  config = function()
    -- require('incline').setup()

    local helpers = require 'incline.helpers'
    local devicons = require 'nvim-web-devicons'
    require('incline').setup {
      highlight = {
        groups = {
          InclineNormal = { guibg = "#1a1e22" },
          InclineNormalNC = { guibg = "#1a1e22" }
        }
      },
      window = {
        padding = 0,
        margin = { horizontal = 0 },
      },
      render = function(props)
        local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
        if filename == '' then
          filename = '[No Name]'
        end
        local ft_icon, ft_color = devicons.get_icon_color(filename)
        local modified = vim.bo[props.buf].modified
        return {
          ft_icon and { ' ', ft_icon, guifg = ft_color } or '',
          -- ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
          ' ',
          { filename, gui = modified and 'bold,italic' or 'bold' },
          ' ',
          -- guibg = '#44406e',
        }
      end,
    }
  end,
  -- Optional: Lazy load Incline
  event = 'VeryLazy',
}
