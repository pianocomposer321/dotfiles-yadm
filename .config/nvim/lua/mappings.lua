vim.g.mapleader = " "
-- vim.g.maplocalleader = "\"

vim.keymap.set("n", "<LEADER>w", "<C-W>")
vim.keymap.set("n", "]c", "<CMD>cnext<CR>")
vim.keymap.set("n", "[c", "<CMD>cprev<CR>")

-- Mappings that I lied from helix
--- Movement
vim.keymap.set({"n", "v", "o"}, "gl", "$")
vim.keymap.set({"n", "v", "o"}, "gh", "0")
vim.keymap.set({"n", "v", "o"}, "gs", "^")
vim.keymap.set({"n", "v", "o"}, "ge", "G")
vim.keymap.set({"n", "v", "o"}, "gm", "%")

--- Alternate file
vim.keymap.set("n", "ga", "<C-6>")
--- Redo
vim.keymap.set("n", "U", "<C-R>")

--- Diagnostics
vim.keymap.set("n", "<LEADER>d", function() vim.diagnostic.open_float({scope = "cursor"}) end)
vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
