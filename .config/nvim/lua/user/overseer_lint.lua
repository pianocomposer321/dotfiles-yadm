local M = {}

function M.set_lint_cmd(cmd, args, paths)
  local task = require("overseer").new_task {
    cmd = cmd,
    args = args,
    { "on_output_quickfix", errorformat = vim.o.efm, open_on_match = true,
      tail = false, open_height = 8, close = true, set_diagnostics = true },
    { "restart_on_save", paths = paths },
    "on_exit_set_status",
  }
  task:start()
end

return M
