local functions_to_run = {}

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- vim.lsp.config("*", require("user.lsp_utils").lsp_opts)
      -- vim.lsp.config("rust_analyzer", require("user.lsp_utils").lsp_opts)
    end,
    lazy = false,
  },
  {
    "lukas-reineke/lsp-format.nvim",
    config = function()
      require("lsp-format").setup {}
      require("user.lsp_utils").extend_on_attach(function(client)
        require("lsp-format").on_attach(client)
      end)
    end,
    enabled = false,
    lazy = false,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
      local mason_lspconfig = require("mason-lspconfig")
      mason_lspconfig.setup()
      for _, server in ipairs(mason_lspconfig.get_installed_servers()) do
        vim.lsp.config(server, require("user.lsp_utils").lsp_opts)
      end
    end,
    dependencies = {
      "neovim/nvim-lspconfig",
      "williamboman/mason-lspconfig.nvim"
    },
  },
  "williamboman/mason-lspconfig.nvim",
  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "BufReadPost",
    config = function() require("fidget").setup() end
  },
}
