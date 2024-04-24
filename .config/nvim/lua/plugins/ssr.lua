return {
  {
    "cshuaimin/ssr.nvim",
    init = function()
      vim.keymap.set({ "n", "x" }, "<leader>sr", function() require("ssr").open() end)
    end,
    config = true,
    enabled = false,

    -- config = function()
    --   require("ssr").setup()
    -- end,
  },
}
