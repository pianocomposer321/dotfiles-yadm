local utils = require("heirline.utils")
local conditions = require("heirline.conditions")

local mode_colors = {
  n = "red" ,
  i = "green",
  v = "cyan",
  V =  "cyan",
  ["\22"] =  "cyan",
  c =  "orange",
  s =  "purple",
  S =  "purple",
  ["\19"] =  "purple",
  R =  "orange",
  r =  "orange",
  ["!"] =  "red",
  t =  "red",
}

local M = {}

M.Align = { provider = "%=" }
M.Space = { provider = " " }

M.ViMode = {
  -- get vim current mode, this information will be required by the provider
  -- and the highlight functions, so we compute it only once per component
  -- evaluation and store it as a component attribute
  init = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()

    -- execute this only once, this is required if you want the ViMode
    -- component to be updated on operator pending mode
    if not self.once then
      vim.api.nvim_create_autocmd("ModeChanged", {
        pattern = "*:*o",
        command = 'redrawstatus'
      })
      self.once = true
    end
  end,
  -- Now we define some dictionaries to map the output of mode() to the
  -- corresponding string and color. We can put these into `static` to compute
  -- them at initialisation time.
  static = {
    mode_names = { -- change the strings if you like it vvvvverbose!
      n = "NOR",
      no = "NOP",
      nov = "NOP",
      noV = "NOP",
      ["no\22"] = "NOP",
      niI = "NOR",
      niR = "NOR",
      niV = "NOR",
      nt = "NOR",
      v = "VIS",
      vs = "VOP",
      V = "VLN",
      Vs = "VOP",
      ["\22"] = "VBL",
      ["\22s"] = "VBL",
      s = "SEL",
      S = "SLN",
      ["\19"] = "SBL",
      i = "INS",
      ic = "INS",
      ix = "INS",
      R = "REP",
      Rc = "REP",
      Rx = "REP",
      Rv = "REP",
      Rvc = "REP",
      Rvx = "REP",
      c = "CMD",
      cv = "EX",
      r = "...",
      rm = "MOR",
      ["r?"] = "CFM",
      ["!"] = "SHL",
      t = "TER",
    },
  },
  -- We can now access the value of mode() that, by now, would have been
  -- computed by `init()` and use it to index our strings dictionary.
  -- note how `static` fields become just regular attributes once the
  -- component is instantiated.
  -- To be extra meticulous, we can also add some vim statusline syntax to
  -- control the padding and make sure our string is always at least 2
  -- characters long. Plus a nice Icon.
  provider = function(self)
    -- return "%4("..self.mode_names[self.mode].."%)"
    return " " .. self.mode_names[self.mode] .. " "
  end,
  -- Same goes for the highlight. Now the foreground will change according to the current mode.
  hl = function(self)
    local mode = self.mode:sub(1, 1) -- get only the first mode character
    return { fg = utils.get_highlight("Normal").bg, bg = mode_colors[mode], bold = true, }
  end,
  -- Re-evaluate the component only on ModeChanged event!
  -- This is not required in any way, but it's there, and it's a small
  -- performance improvement.
  update = {
    "ModeChanged",
    "CmdlineLeave",
  },
}

M.FileModified = {
  condition = function()
    return vim.bo.modified
  end,
  provider = "[+]",
  hl = { fg = "green" },
}

M.FileName = {
  provider = function()
    local filename = vim.api.nvim_buf_get_name(0)
    local fname_rel = vim.fn.fnamemodify(filename, ":.")
    return filename == "" and "[No Name]" or fname_rel
  end,
  hl = { fg = utils.get_highlight("Directory").fg },
}

local function pad(s)
  local s_len = utils.count_chars(s)
  if s_len == 1 then
    s = "0"..s
  end
  return s
end

M.Ruler = {
  init = function(self)
    self.mode = vim.fn.mode(1) -- :h mode()
  end,
  provider = function()
    local line = pad("%l")
    local col = pad("%c")
    -- local col_len = utils.count_chars(col)
    -- if col_len == 1 then
    --   col = "0"..col
    -- end
    return " "..line..":"..col.." "
  end,
  hl = function(self)
    local mode = self.mode:sub(1, 1)
    return { fg = utils.get_highlight("Normal").bg, bg = mode_colors[mode], bold = true, }
  end
}


M.LSPActive = {
  condition = conditions.lsp_attached,
  update = {'LspAttach', 'LspDetach'},

  -- You can keep it simple,
  -- provider = " [LSP]",

  -- Or complicate things a bit and get the servers names
  provider  = function()
    local names = {}
    for _, server in pairs(vim.lsp.get_clients({ bufnr = 0 })) do
      table.insert(names, server.name)
    end
    return " [" .. table.concat(names, " ") .. "]"
  end,
  hl = { fg = "green", bold = true },
}

M.Diagnostics = {

  condition = conditions.has_diagnostics,

  static = {
    -- error_icon = "E: ",
    -- warn_icon = "W: ",
    -- info_icon = "I: ",
    -- hint_icon = "H: ",
    error_icon = vim.fn.sign_getdefined("DiagnosticSignError")[1].text,
    warn_icon = vim.fn.sign_getdefined("DiagnosticSignWarn")[1].text,
    info_icon = vim.fn.sign_getdefined("DiagnosticSignInfo")[1].text,
    hint_icon = vim.fn.sign_getdefined("DiagnosticSignHint")[1].text,
  },

  init = function(self)
    self.errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    self.warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
    self.hints = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
    self.info = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
  end,

  update = { "DiagnosticChanged", "BufEnter" },

  {
    provider = function(self)
      -- 0 is just another output, we can decide to print it or not!
      return self.errors > 0 and (self.error_icon .. self.errors .. " ")
    end,
    hl = { fg = "diag_error" },
  },
  {
    provider = function(self)
      return self.warnings > 0 and (self.warn_icon .. self.warnings .. " ")
    end,
    hl = { fg = "diag_warn" },
  },
  {
    provider = function(self)
      return self.info > 0 and (self.info_icon .. self.info .. " ")
    end,
    hl = { fg = "diag_info" },
  },
  {
    provider = function(self)
      return self.hints > 0 and (self.hint_icon .. self.hints)
    end,
    hl = { fg = "diag_hint" },
  },
}

M.Git = {
    condition = conditions.is_git_repo,

    init = function(self)
        self.status_dict = vim.b.gitsigns_status_dict
        self.has_changes = self.status_dict.added ~= 0 or self.status_dict.removed ~= 0 or self.status_dict.changed ~= 0
    end,

    hl = { fg = "orange" },


    {   -- git branch name
        provider = function(self)
            return " " .. self.status_dict.head
        end,
        hl = { bold = true }
    },
    -- You could handle delimiters, icons and counts similar to Diagnostics
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = "("
    },
    {
        provider = function(self)
            local count = self.status_dict.added or 0
            return count > 0 and ("+" .. count)
        end,
        hl = { fg = "git_add" },
    },
    {
        provider = function(self)
            local count = self.status_dict.removed or 0
            return count > 0 and ("-" .. count)
        end,
        hl = { fg = "git_del" },
    },
    {
        provider = function(self)
            local count = self.status_dict.changed or 0
            return count > 0 and ("~" .. count)
        end,
        hl = { fg = "git_change" },
    },
    {
        condition = function(self)
            return self.has_changes
        end,
        provider = ")",
    },
}

return M
