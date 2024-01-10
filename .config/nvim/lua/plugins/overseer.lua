
return {
  {
    "stevearc/overseer.nvim",
    -- dev = true,
    cmd = {"Make", "Run"},
    init = function()
      local util = require("user.overseer_util")
      local overseer = require("overseer")
      vim.keymap.set("n", "<LEADER>ro", function() overseer.toggle() end)
      vim.keymap.set("n", "<LEADER>rr", function() overseer.run_template { prompt = "avoid" } end)
      vim.keymap.set("n", "<LEADER><CR>", util.restart_last_task)
      vim.keymap.set("n", "<LEADER>ra", function() overseer.commands.task_action() end)
      vim.keymap.set("n", "<LEADER>rv", util.open_vsplit_last)
    end,
    config = function()
      local overseer = require("overseer")

      local opts = {}

      overseer.setup(opts)
      -- Add `unique` component to all vscode tasks
      overseer.add_template_hook({
        module = "vscode",
      }, function(task_defn, a_util)
        a_util.add_component(task_defn, { "unique" })
      end)
    end
  },
}
