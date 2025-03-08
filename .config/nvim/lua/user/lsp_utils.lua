local M = {}

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

local capabilities = {}

M.lsp_opts = {
  capabilities = setmetatable({}, {
    __index = function(table, key)
      table[key] = capabilities[key]
      return capabilities[key]
    end,
  }),
  on_attach = on_attach
}

function M.add_capabilities(c)
  capabilities = vim.tbl_extend("force", capabilities, c)
end

function M.get_capabilities(key)
  return M.lsp_opts.capabilities[key]
end

function M.extend_on_attach(fn)
  table.insert(functions_to_run, fn)
end

return M
