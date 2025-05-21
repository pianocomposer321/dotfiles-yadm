local functions_to_run = {}

return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp_utils = require("user.lsp_utils")

      local configs = require('lspconfig.configs')
      local lspconfig = require('lspconfig')
      if not configs['v-analyzer'] then
        configs['v-analyzer'] = {
          default_config = {
            cmd = { 'v-analyzer' },
            root_dir = lspconfig.util.root_pattern('.git', '.v-analyzer'),
            filetypes = { 'v', 'vlang' },
          },
        }
      end
      if not configs['sourcekit-lsp'] then
        configs['sourcekit-lsp'] = {
          default_config = {
            cmd = { 'sourcekit-lsp' },
            root_dir = lspconfig.util.root_pattern('.git', 'Package.swift'),
            filetypes = { 'swift' },
          },
        }
      end

      lspconfig['v-analyzer'].setup(lsp_utils.lsp_opts)
      lspconfig['sourcekit-lsp'].setup(lsp_utils.lsp_opts)
      lspconfig['racket_langserver'].setup(lsp_utils.lsp_opts)
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
      local lspconfig = require("lspconfig")
      local lsp_utils = require("user.lsp_utils")

      vim.lsp.config("*", lsp_utils.lsp_opts)

      --- lua_ls
      local has_neodev, neodev_lsp = pcall(require, "neodev.lsp")
      local before_init
      if has_neodev then
        before_init = neodev_lsp.before_init
      end

      vim.lsp.config("lua_ls", {
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
      })


      -- require("mason-lspconfig").setup_handlers {
      --   function(server_name)
      --     lspconfig[server_name].setup(lsp_utils.lsp_opts)
      --   end,
      --
      --   ["lua_ls"] = function()
      --     local has_neodev, neodev_lsp = pcall(require, "neodev.lsp")
      --     local before_init
      --     if has_neodev then
      --       before_init = neodev_lsp.before_init
      --     end
      --
      --     lspconfig.lua_ls.setup(vim.tbl_extend("force", lsp_utils.lsp_opts, {
      --       before_init = before_init,
      --       settings = {
      --         Lua = {
      --           diagnostics = {
      --             globals = { "vim" }
      --           },
      --           workspace = {
      --             checkThirdParty = false
      --           }
      --         }
      --       },
      --     }))
      --   end,
      --   ["rust_analyzer"] = function()
      --     lspconfig.rust_analyzer.setup(vim.tbl_extend("force", lsp_utils.lsp_opts, {
      --       settings = {
      --         ["rust-analyzer"] = {
      --           diagnostics = {
      --             disabled = {
      --               "inactive-code"
      --             }
      --           }
      --           -- cargo = {
      --           --   extraEnv = {
      --           --     RUSTFLAGS = "--cfg rust_analyzer"
      --           --   }
      --           -- }
      --         }
      --       }
      --     }))
      --   end
      -- }

      require("mason").setup()
      require("mason-lspconfig").setup()
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
