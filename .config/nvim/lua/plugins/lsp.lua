local functions_to_run = {}

local function on_attach(client, bufnr)
  local bufopts = { buffer = bufnr }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "<LEADER>k", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "<LEADER>lr", vim.lsp.buf.rename, bufopts)
  vim.keymap.set({ "n", "v" }, "<LEADER>a", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set({ "o", "v" }, "gq", function() vim.lsp.buf.format({
    async = true
  })
  end)

  for _, f in ipairs(functions_to_run) do
    f(client, bufnr)
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
  },
  {
    "lukas-reineke/lsp-format.nvim",
    config = function()
      require("lsp-format").setup {}
      table.insert(functions_to_run, function(client)
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
      local lspconfig = require("lspconfig")

      local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = {}
      if has_cmp_nvim_lsp then
        capabilities = cmp_nvim_lsp.default_capabilities()
      end

      local lsp_opts = {
        capabilities = capabilities,
        on_attach = on_attach
      }

      require("mason").setup()
      require("mason-lspconfig").setup()

      require("mason-lspconfig").setup_handlers {
        function(server_name)
          lspconfig[server_name].setup(lsp_opts)
        end,

        ["lua_ls"] = function()
          local has_neodev, neodev_lsp = pcall(require, "neodev.lsp")
          local before_init
          if has_neodev then
            before_init = neodev_lsp.before_init
          end

          lspconfig.lua_ls.setup(vim.tbl_extend("force", lsp_opts, {
            before_init = before_init,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" }
                },
                workspace = {
                  checkThirdParty = false
                }
              }
            },
          }))
        end,
        ["rust_analyzer"] = function()
          lspconfig.rust_analyzer.setup(vim.tbl_extend("force", lsp_opts, {
            settings = {
              ["rust-analyzer"] = {
                diagnostics = {
                  disabled = {
                    "inactive-code"
                  }
                }
                -- cargo = {
                --   extraEnv = {
                --     RUSTFLAGS = "--cfg rust_analyzer"
                --   }
                -- }
              }
            }
          }))
        end
      }
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
