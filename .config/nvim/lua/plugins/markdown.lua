return {
  {
    ft = "markdown",
    'MeanderingProgrammer/render-markdown.nvim',
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },            -- if you use the mini.nvim suite
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.icons' },        -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      render_modes = { 'n', 'c', 't', 'v', 'V', 'i' },
      -- win_options = {
      --   concealcursor = { rendered = 'c' }
      -- }
      -- anti_conceal = {
      --   enabled = true,
      --   disabled_modes = false,
      -- },
    },
  },
  {
    enabled = false,
    'jakewvincent/mkdnflow.nvim',
    ft = { 'markdown', 'rmd' },  -- Add custom filetypes here if configured
    opts = true,
  },
  {
    "yousefhadder/markdown-plus.nvim",
    ft = "markdown",
    opts = {},
  },
  {
    enabled = false,
    "toppair/peek.nvim",
    -- event = { "VeryLazy" },
    ft = { "markdown", "typst" },
    build = "deno task --quiet build:fast",
    config = function()
      require("peek").setup()
      vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
      vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
    end,
  },
  -- {
  --   enabled = false,
  --   "iamcco/markdown-preview.nvim",
  --   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  --   build = "cd app && yarn install",
  --   init = function()
  --     vim.g.mkdp_filetypes = { "markdown" }
  --     -- _G.MkdpOpenBrowser = function(url)
  --     --   vim.fn.system("open -n -a 'Brave Browser' --args --app=" .. url)
  --     -- end
  --
  --     vim.cmd([[
  --     function MkdpOpenBrowser(url)
  --       execute "silent ! open -n -a 'Brave Browser' --args --app=" . a:url
  --     endfunction
  --     ]])
  --
  --     vim.g.mkdp_browserfunc = "MkdpOpenBrowser"
  --   end,
  --   ft = { "markdown" },
  -- },
  {
    enabled = false,
    "brianhuster/live-preview.nvim",
    ft = "markdown",
    opts = true,
  },
  {
    "selimacerbas/markdown-preview.nvim",
    dependencies = { "selimacerbas/live-server.nvim" },
    ft = "markdown",
    dev = true,
    -- enabled = false,
    config = function()
      require("markdown_preview").setup({
        -- all optional; sane defaults shown
        instance_mode = "takeover",  -- "takeover" (one tab) or "multi" (tab per instance)
        port = 0,                    -- 0 = auto (8421 for takeover, OS-assigned for multi)
        open_browser = true,
        debounce_ms = 25,
      })
    end,
  },
}
