local windows = {}
local count_windows = 0
---@type number?
local last_window

local augroup = vim.api.nvim_create_augroup("overseer_user_open_on_start", {})

local M = {}

local get_size = function() return vim.o.columns * 0.4 end

M.resize_windows_on_stack = function()
  local each_height = math.floor(vim.o.lines / count_windows)
  for _, window in pairs(windows) do
    vim.api.nvim_win_set_height(window, each_height)
  end
end

M.add_window_to_stack = function(bufnr)
  if not last_window or not vim.api.nvim_win_is_valid(last_window) then
    M.create_window(bufnr, "botright vertical", get_size())
    return
  end
  vim.api.nvim_set_current_win(last_window)
  M.create_window(bufnr, "belowright")
  M.resize_windows_on_stack()
end

M.create_window = function(bufnr, modifier, size)
  if size == nil
    then size = ""
  elseif type(size) == "function"
    then size = size()
  end

  local cmd = "split"
  if modifier ~= "" then
    cmd = modifier .. " " .. size .. cmd
  end
  vim.cmd(cmd)

  local winid = vim.api.nvim_get_current_win()
  windows[bufnr] = winid
  last_window = winid
  count_windows = count_windows + 1
  vim.wo[winid].winfixwidth = true
  vim.wo[winid].winfixheight = true

  vim.api.nvim_create_autocmd("WinClosed", {
    group = augroup,
    pattern = tostring(winid),
    callback = function()
      windows[bufnr] = nil
      return true
    end
  })
end

M.close_window = function(bufnr)
  local winid = windows[bufnr]
  windows[bufnr] = nil
  if not winid then
    return false
  end

  if not vim.api.nvim_win_is_valid(winid) then
    return false
  end

  vim.api.nvim_win_close(winid, false)
end

return M
