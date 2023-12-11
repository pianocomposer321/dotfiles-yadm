local overseer = require("overseer")
local util = require("user.overseer_util")

local function spawn_cmd(cmd, params)
  local task = overseer.new_task({
    cmd = cmd,
    components = {
      { "on_output_quickfix", errorformat = vim.o.efm, open_on_match = not params.bang, tail = false, open_height = 8, close = true },
      { "user.open_on_start", modifier = "botright vertical", close_on_exit = params.bang and "always" or "never", size = function() return vim.o.columns * 0.4 end },
      { "user.track_history" },
      "on_exit_set_status",
    },
  })
  task:start()
end

local M = {}

function M.setup_commands()
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

function M.setup_mappings()
  vim.keymap.set("n", "<LEADER>ro", function() overseer.toggle() end)
  vim.keymap.set("n", "<LEADER>rr", function() overseer.run_template { prompt = "avoid" } end)
  vim.keymap.set("n", "<LEADER><CR>", util.restart_last_task)
  vim.keymap.set("n", "<LEADER>ra", function() overseer.commands.task_action() end)
  vim.keymap.set("n", "<LEADER>rv", util.open_vsplit_last)

  vim.keymap.set("n", "m<SPACE>", ":Make<SPACE>")
  vim.keymap.set("n", "m<CR>", ":Make<CR>")
  vim.keymap.set("n", "m!", ":Make!<SPACE>")
  vim.keymap.set("n", "M<SPACE>", ":Run<SPACE>")
  vim.keymap.set("n", "M<CR>", ":Run<CR>")
  vim.keymap.set("n", "M!", ":Run!<SPACE>")
end

return M
