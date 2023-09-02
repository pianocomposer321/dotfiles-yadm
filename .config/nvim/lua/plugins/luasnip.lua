local local_snippets_dir = vim.fn.finddir("snippets", ".;")

return {
  "L3MON4D3/LuaSnip",
  dependencies = "honza/vim-snippets",
  event = "VeryLazy",
  init = function()
    vim.keymap.set({"i", "s"}, "<C-j>", function() require("luasnip").expand_or_jump(1) end)
    vim.keymap.set({"i", "s"}, "<C-k>", function() require("luasnip").jump(-1) end)

    vim.api.nvim_create_user_command("LuaSnipEdit", function()
      vim.cmd.edit(string.format("%s/%s.snippets", "~/.config/nvim/snippets", vim.o.ft))
    end, {})

    vim.api.nvim_create_user_command("LuaSnipEditLocal", function()
      if #local_snippets_dir == 0 then
        vim.fn.mkdir("snippets")
      end

      vim.cmd.edit(string.format("%s/%s.snippets", local_snippets_dir, vim.o.ft))
    end, {})

    -- vim.api.nvim_create_user_command("LuaSnipEdit", function()
    --   -- require("luasnip.loaders").edit_snippet_files {}
    --   require("luasnip.loaders").edit_snippet_files {
    --     extend = function(ft, paths)
    --       -- if #paths == 0 then
    --         return {
    --           { "$CONFIG/" .. ft .. ".snippets",
    --           string.format("%s/%s.snippets", "~/.config/nvim/snippets", ft) }
    --         }
    --       -- end
    --
    --       -- return {}
    --     end
    --   }
    -- end, {})

  end,
  config = function()
    local paths = vim.api.nvim_get_runtime_file("snippets", true)
    if #local_snippets_dir > 0 then
      print("adding snippets folder: ", local_snippets_dir)
      table.insert(paths, local_snippets_dir)
    end
    require("luasnip.loaders.from_snipmate").lazy_load({paths = paths})
  end
}
