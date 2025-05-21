return {
  -- "hrsh7th/cmp-nvim-lsp-signature-help",
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
    config = function()
      local cmp = require("cmp")
---@diagnostic disable-next-line: missing-fields
      cmp.setup {
        sources = {
          { name = "nvim_lsp" },
          -- { name = "nvim_lsp_signature_help" },
          -- { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        mapping = {
          ["<C-N>"] = cmp.mapping.select_next_item(),
          ["<C-P>"] = cmp.mapping.select_prev_item(),
          ["<C-Y>"] = cmp.mapping.confirm(),
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        preselect = cmp.PreselectMode.None,
---@diagnostic disable-next-line: missing-fields
        formatting = {
          format = function(_, vim_item)
            local shortened = string.sub(vim_item.abbr, 1, 19)
            if shortened:len() < vim_item.abbr:len() then
              vim_item.abbr = shortened .. "…"
            end
            return vim_item
          end
        },
      }
    end,
    event = "InsertEnter",
    dependencies = {
      {
        "hrsh7th/cmp-nvim-lsp",
        init = function()
          require("user.lsp_utils").add_capabilities(require("cmp_nvim_lsp").default_capabilities())
        end,
      },
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      {
        "saadparwaiz1/cmp_luasnip",
        dependencies = "L3MON4D3/LuaSnip"
      },
    },
  },
  {
    "folke/neodev.nvim",
    enabled = false,
    lazy = false,
    config = function()
      require("neodev").setup {
        lspconfig = false
      }
    end
  },
}
