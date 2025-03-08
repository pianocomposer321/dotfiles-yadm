local mc = require("multicursor-nvim")
local augroup = vim.api.nvim_create_augroup("AddCursorMode", {})

-- TODO: Extract into plugin
-- TODO: Make skip function

local function get_cursor_position()
  local pos = vim.api.nvim_win_get_cursor(0)
  return { pos[1], pos[2] + 1 }
end

local cursor_mode = false

_G.StartCursorMode = function()
  cursor_mode = true
  local prev_position = get_cursor_position()

  vim.api.nvim_create_autocmd("CursorMoved", {
    callback = function()
      mc.action(function(ctx)
        local new_cursor = ctx:addCursor()
        new_cursor:setPos(prev_position)
        prev_position = get_cursor_position()
      end)
    end,
    group = augroup
  })
end

_G.StopCursorMode = function()
  cursor_mode = false
  vim.api.nvim_clear_autocmds({group = "AddCursorMode"})
end

vim.keymap.set("n", "<LEADER>ca", function()
  if cursor_mode then
    StopCursorMode()
  else
    StartCursorMode()
  end
end)
