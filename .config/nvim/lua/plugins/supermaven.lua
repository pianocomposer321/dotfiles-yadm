local loaded = false

return {
  "supermaven-inc/supermaven-nvim",
  event = "VeryLazy",
  config = function()
    vim.keymap.set("n", "<leader>mt", function()
      if loaded then vim.cmd("SupermavenToggle")
      else
        require("supermaven-nvim").setup({ disable_keymaps = true })
        vim.keymap.set("i", "<C-f>", require("supermaven-nvim.completion_preview").on_accept_suggestion)
        loaded = true
      end
    end)
  end,
}
