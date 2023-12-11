return {
  {
    "stevearc/overseer.nvim",
    -- dev = true,
    cmd = {"Make", "Run"},
    init = function()
      local overseer = require("overseer")
      local util = require("user.overseer_util")

      local function open_vsplit_last()
        local task = util.get_last_task()
        if task then
          local bufnr = task:get_bufnr()
          -- require("user.overseer_ui").create_window(bufnr, "botright vertical", vim.o.columns * 0.4)
          require("user.overseer_ui").add_window_to_stack(bufnr)
          vim.api.nvim_win_set_buf(0, bufnr)
        end
      end

      vim.keymap.set("n", "<LEADER>ro", function() overseer.toggle() end)
      vim.keymap.set("n", "<LEADER>rr", function() overseer.run_template { prompt = "avoid" } end)
      vim.keymap.set("n", "<LEADER><CR>", util.restart_last_task)
      vim.keymap.set("n", "<LEADER>ra", function() overseer.commands.task_action() end)
      vim.keymap.set("n", "<LEADER>rv", open_vsplit_last)

      vim.keymap.set("n", "m<SPACE>", ":Make<SPACE>")
      vim.keymap.set("n", "m<CR>", ":Make<CR>")
      vim.keymap.set("n", "m!", ":Make!<SPACE>")
      vim.keymap.set("n", "M<SPACE>", ":Run<SPACE>")
      vim.keymap.set("n", "M<CR>", ":Run<CR>")
      vim.keymap.set("n", "M!", ":Run!<SPACE>")
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
      }, function(task_defn, a_util)
        a_util.add_component(task_defn, { "unique" })
      end)

      local function spawn_cmd(cmd, params)
        local task = overseer.new_task({
          cmd = cmd,
          -- strategy = strategy,
          components = {
            -- { "on_output_quickfix", errorformat = vim.o.efm, open_on_exit = params.bang and "never" or "failure", open_height = 8 },
            { "on_output_quickfix", errorformat = vim.o.efm, open_on_match = not params.bang, tail = false, open_height = 8, close = true },
            { "user.open_on_start", modifier = "botright vertical", close_on_exit = params.bang and "always" or "never", size = function() return vim.o.columns * 0.4 end },
            { "user.track_history" },
            "on_exit_set_status",
            -- "default",
          },
        })
        task:start()
      end

      local cmd_opts = {
        desc = "",
        nargs = "*",
        bang = true,
        complete = "file",
      }
      vim.api.nvim_create_user_command("Make", function(params)
        local args = vim.fn.expandcmd(params.args)
        local cmd, num_subs = vim.o.makeprg:gsub("%$%*", args)
        if num_subs == 0 then
          cmd = cmd .. " " .. args
        end

        -- local strategy = opts.strategy
        -- strategy.open_on_start = not params.bang
        spawn_cmd(cmd, params)
      end, cmd_opts)

      vim.api.nvim_create_user_command("Run", function(params)
        local cmd = vim.fn.expandcmd(params.args)
        spawn_cmd(cmd, params)
      end, cmd_opts)

      vim.api.nvim_create_user_command("RunOpen", function(params)
        local cmd = vim.fn.expandcmd(params.args)
        spawn_cmd(cmd, params)
      end, cmd_opts)
  end
  },
}
