return {
  {
    "stevearc/overseer.nvim",
    -- dev = true,
    cmd = {"Make", "Run"},
    init = function()
      require("user.overseer_dispatch").setup_mappings()
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

      require("user.overseer_dispatch").setup_commands()
    end
  },
}
