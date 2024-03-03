return {
  {
    "MunifTanjim/exrc.nvim",
    lazy = false,
    enabled = false,
    config = function()
      require("exrc").setup {
        files = {
          ".nvimrc.lua",
          ".nvimrc",
        }
      }
    end
  },
}
