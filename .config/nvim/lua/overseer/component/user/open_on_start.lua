local windows = {}

local augroup = vim.api.nvim_create_augroup("overseer_user_open_on_start", {})

local function create_window(modifier, bufnr)
  local cmd = "split"
  if modifier ~= "" then
    cmd = modifier .. " " .. cmd
  end
  vim.cmd(cmd)

  local winid = vim.fn.win_getid()
  windows[bufnr] = winid

  vim.api.nvim_create_autocmd("WinClosed", {
    group = augroup,
    pattern = tostring(winid),
    callback = function()
      windows[bufnr] = nil
      return true
    end
  })
end

local function close_window(bufnr)
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

return {
  desc = "Open buffer on task start",
  params = {
    modifier = {
      desc = "Direction modifier for window created",
      type = "string",
      default = "",
    },
    close_on_exit = {
      desc = "Close the window on exit",
      type = "enum",
      choices = { "never", "success", "always" },
      default = "never",
    },
  },
  constructor = function(params)
    return {
      on_start = function(_, task)
        local bufnr = task:get_bufnr()
        create_window(params.modifier, bufnr)
        vim.api.nvim_win_set_buf(0, bufnr)
        require("overseer.util").scroll_to_end(0)
      end,
      on_exit = function(_, task, code)
        local close = params.close_on_exit == "always"
        close = close or (params.close_on_exit == "success" and code == 0)
        if close then
          close_window(task:get_bufnr())
        end
      end,
    }
  end,
}
