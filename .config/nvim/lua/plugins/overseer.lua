return {
  {
    "stevearc/overseer.nvim",
    dev = true,
    cmd = "Make",
    init = function()
      local overseer = require("overseer")

      local function get_last()
        local tasks = overseer.list_tasks {recent_first = true}
        if vim.tbl_isempty(tasks) then
          vim.notify("No tasks found", vim.log.levels.WARN)
          return false
        else
          return tasks[1]
        end
      end

      local function restart_last()
        overseer.run_action(get_last(), "restart")
      end

      local function open_vsplit_last()
        overseer.run_action(get_last(), "open vsplit")
      end

      vim.keymap.set("n", "<LEADER>ro", function() overseer.toggle() end)
      vim.keymap.set("n", "<LEADER>rr", function() overseer.run_template { prompt = "avoid" } end)
      vim.keymap.set("n", "<LEADER><CR>", restart_last)
      vim.keymap.set("n", "<LEADER>ra", function() overseer.commands.task_action() end)
      vim.keymap.set("n", "<LEADER>rv", open_vsplit_last)

      vim.keymap.set("n", "m<SPACE>", ":Make<SPACE>")
      vim.keymap.set("n", "m<CR>", ":Make<CR>")
    end,
    config = function()
      local overseer = require("overseer")

      local opts = {}

      -- opts.strategy = { "user.terminal" }

      -- if pcall(require, "toggleterm") then
      --   opts.strategy = { "toggleterm", open_on_start = true, quit_on_exit = "always", direction = "vertical" }
      -- end

      overseer.setup(opts)
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
            { "on_output_quickfix", errorformat = vim.o.efm, open_on_exit = params.bang and "never" or "failure", open_height = 8 },
            "default",
          },
        })
        task:start()
      end, {
        desc = "",
        nargs = "*",
        bang = true,
      })
  end
  },
}
