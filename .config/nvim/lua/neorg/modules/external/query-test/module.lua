local neorg  = require("neorg.core")
local module = neorg.modules.create("external.query-test")
local log = neorg.log

module.setup = function()
  return {
    success = true,
    requires = { "core.queries.native" },
  }
end

module.private = {
  ---@param path string
  ---@return integer
  load_temp_buf = function(path)
    local file, error = io.open(path, "r")
    if not file then
      log.warn("Can't read file " .. path)
      log.error(error)
      return -1
    end
    local lines = vim.split(file:read("*a"), "\n")
    if lines[#lines] == "" then
      -- vim.split automatically adds an empty line because the file stops with a newline
      table.remove(lines)
    end
    file:close()

    local temp_buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(temp_buf, 0, -1, false, lines)
    vim.api.nvim_buf_set_option(temp_buf, "filetype", "norg")
    return temp_buf
  end
}

module.load = function()
  -- local file = io.open("/home/composer3/notes/tasks.norg")
  -- local tree = {
  --   {
  --     query = { "all", "strong_carryover" },
  --     recursive = true,
  --     subtree = {
  --       {
  --         query = { "first", "tag_name" },
  --         recursive = true,
  --       }
  --     }
  --   }
  -- }
  -- local nodes = module.required["core.queries.native"].query_nodes_from_buf(tree, 1)
  -- if vim.treesitter.get_node_text(nodes[1][1], nodes[1][2], {}) == "task" then
  --   local sibling = nodes[1][1]:parent():parent():next_sibling()
  --   vim.print(vim.treesitter.get_node_text(sibling, nodes[1][2], {}))
  -- end
end

return module
