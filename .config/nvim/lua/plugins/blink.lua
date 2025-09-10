return {
  'saghen/blink.cmp',
  event = "InsertEnter",
  opts = {
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },
    completion = {
      list = {
        selection = {
          preselect = false,
        }
      },
    },
    snippets = { preset = "luasnip" },
    signature = { enabled = true },
  },
  -- config = true,
  version = "1.*",
}
