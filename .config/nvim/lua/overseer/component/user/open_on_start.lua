local oui = require("user.overseer_ui")

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
    size = {
      desc = "Size of the window to create",
      type = "opaque",
    },
  },
  constructor = function(params)
    return {
      on_start = function(_, task)
        local bufnr = task:get_bufnr()
        oui.create_window(bufnr, params.modifier, params.size)
        vim.api.nvim_win_set_buf(0, bufnr)
        require("overseer.util").scroll_to_end(0)
      end,
      on_exit = function(_, task, code)
        local close = params.close_on_exit == "always"
        close = close or (params.close_on_exit == "success" and code == 0)
        if close then
          oui.close_window(task:get_bufnr())
        end
      end,
    }
  end,
}
