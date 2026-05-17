" set textwidth=80
if &buftype == 'nofile'
  finish
endif

set formatoptions+=n
set wrap
set breakindent
set breakindentopt=list:-1
set lbr
set nonu
set signcolumn=yes

setlocal spell
set indentexpr=

nnoremap j gj
nnoremap k gk

lua << END
require("user.lsp_utils").extend_on_attach(function(client)
  if client.name == "markdown_oxide" then
    vim.api.nvim_create_user_command(
      "Daily",
      function(args)
        local input = args.args

        vim.lsp.buf.execute_command({command="jump", arguments={input}})

      end,
      {desc = 'Open daily note', nargs = "*"}
    )
  end
end)
END
