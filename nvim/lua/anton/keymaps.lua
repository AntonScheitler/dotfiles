-- Plugin-specific keymaps live next to their plugin in lua/anton/plugins/.
local map = vim.keymap.set

map("n", "<leader>er", vim.cmd.Ex)

-- Keep the cursor centered when jumping
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")
map("n", "n", "nzz")
map("n", "N", "Nzz")

-- Yank to system clipboard
map({ "n", "v" }, "<leader>y", [["+y]])

-- Paste / delete / change without clobbering the default register
map("x", "<leader>p", [["_d<Left>p]])
map({ "n", "v" }, "<leader>d", [["_d]])
map({ "n", "v" }, "<leader>c", [["_c]])

-- Substitute the word under the cursor across the file
map("n", "<leader>s", [[:%s/<C-r><C-w>//g<Left><Left>]])

map("n", "==", vim.lsp.buf.format)

map("i", "<C-c>", "<Esc>")
map("n", "<Tab>", "<Nop>")

-- Windows: split
map("n", "<leader>v", "<C-w>v")
map("n", "<leader>b", "<C-w>s")

-- Windows: navigate
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Windows: move
map("n", "<leader>H", "<C-w>H")
map("n", "<leader>J", "<C-w>J")
map("n", "<leader>K", "<C-w>K")
map("n", "<leader>L", "<C-w>L")

-- Windows: resize
map("n", "<C-w>h", "<cmd>vertical resize +5<CR>")
map("n", "<C-w>j", "<cmd>resize +5<CR>")
map("n", "<C-w>k", "<cmd>resize -5<CR>")
map("n", "<C-w>l", "<cmd>vertical resize -5<CR>")
