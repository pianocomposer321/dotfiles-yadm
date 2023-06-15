local function restart_last()
  local tasks = require("overseer").list_tasks {recent_first = true}
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    require("overseer").run_action(tasks[1], "restart")
  end
end

return {
  {
    "stevearc/overseer.nvim",
    cmd = "Make",
    init = function()
      vim.keymap.set("n", "<LEADER>ro", function() require("overseer").toggle() end)
      vim.keymap.set("n", "<LEADER>rr", function() require("overseer").run_template { prompt = "avoid" } end)
      vim.keymap.set("n", "<LEADER><CR>", restart_last)
      vim.keymap.set("n", "<LEADER>ra", function() require("overseer").commands.task_action() end)
    end,
    config = function()
      local overseer = require("overseer")
      overseer.setup()
      -- Add `unique` component to all vscode tasks
      overseer.add_template_hook({
        module = "vscode",
      }, function(task_defn, util)
        util.add_component(task_defn, { "unique" })
      end)

      vim.api.nvim_create_user_command("Make", function(params)
        local args = vim.fn.expandcmd(params.args)
        -- Insert args at the '$*' in the grepprg
        local cmd, num_subs = vim.o.makeprg:gsub("%$%*", args)
        if num_subs == 0 then
          cmd = cmd .. " " .. args
        end

        local task = overseer.new_task({
          cmd = cmd,
          components = {
            { "on_output_quickfix", errorformat = vim.o.efm, open = not params.bang, open_height = 8 },
            "default",
          },
        })
        task:start()
        overseer.run_action(task, "open vsplit")
      end, {
        desc = "",
        nargs = "*",
        bang = true,
      })
  end
  },
}
