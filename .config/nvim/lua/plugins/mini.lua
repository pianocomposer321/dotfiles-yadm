local keys = {
  ['cr']        = vim.api.nvim_replace_termcodes('<CR>', true, true, true),
  ['ctrl-y']    = vim.api.nvim_replace_termcodes('<C-y>', true, true, true),
  ['ctrl-y_cr'] = vim.api.nvim_replace_termcodes('<C-y><CR>', true, true, true),
}

local function _cr_action()
  if vim.fn.pumvisible() ~=0 then
    local item_selected = vim.fn.complete_info()['selected'] ~= -1
    return item_selected and keys['ctrl-y'] or keys['ctrl-y_cr']
  else
    return require("mini.pairs").cr()
  end
end

return {
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.surround").setup {}
      -- require("mini.pairs").setup {}
      require("mini.comment").setup {}
      -- require("mini.jump2d").setup {}

      require("mini.files").setup {
        mappings = {
          go_in = "",
          go_out = "",
        }
      }
      vim.keymap.set("n", "-", function()
        local dir = vim.fn.expand("%:h")
        if dir == "" then
          vim.cmd("e.")
        else
          vim.cmd("e " .. dir)
        end
      end)

      -- require("mini.completion").setup {
      --   mappings = {
      --     force_twostep = '',
      --     force_fallback = '',
      --   }
      -- }
      -- vim.keymap.set("i", "<CR>", cr_action, {expr = true})
    end,
  },
}
