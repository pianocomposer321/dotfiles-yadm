local windows = {}

local augroup = vim.api.nvim_create_augroup("overseer_user_open_on_start", {})

local M = {}

M.create_window = function(bufnr, modifier, size)
  if type(size) == "function" then
    size = size()
  end

  local cmd = "split"
  if modifier ~= "" then
    cmd = modifier .. " " .. size .. cmd
  end
  vim.cmd(cmd)

  local winid = vim.fn.win_getid()
  windows[bufnr] = winid
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
