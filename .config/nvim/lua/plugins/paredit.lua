return {
  "dundalek/parpar.nvim",
  -- lazy = false,
  ft = "racket",
  dependencies = {
    "gpanders/nvim-parinfer",
    "julienvincent/nvim-paredit",
    "ekaitz-zarraga/nvim-paredit-scheme",
  },
  config = function()
    local paredit = require("nvim-paredit")
    require("parpar").setup {
      paredit = {
        use_default_keys = false,
        extensions = {
          racket = require("nvim-paredit-scheme").extension
        },
        keys = {
          ["<A-H>"] = { paredit.api.slurp_backwards, "Slurp backwards" },
          ["<A-J>"] = { paredit.api.barf_backwards, "Barf backwards" },
          ["<A-K>"] = { paredit.api.barf_forwards, "Barf forwards" },
          ["<A-L>"] = { paredit.api.slurp_forwards, "Slurp forwards" },
        },
      },
    }
  end
}
