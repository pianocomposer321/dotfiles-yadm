return {
  ft = "racket",
  dependencies = "wlangstroth/vim-racket",
  -- lazy = false,
  "Olical/conjure",
  -- init = function()
  --   vim.g["conjure#client_on_load"] = false
  -- end,
  config = function()
    require("conjure.main").main()
    require("conjure.mapping")["on-filetype"]()
  end,
}
