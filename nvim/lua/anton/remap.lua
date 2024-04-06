vim.g.mapleader = " "
vim.keymap.set("n", "<leader>er", vim.cmd.Ex)

-- movement
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "N", "Nzz")

-- yank, paste and delete
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")

vim.keymap.set("x", "<leader>p", "\"_dp")

vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")

-- easy rename
vim.keymap.set("n", "<leader>s", [[:%s/<C-r><C-w>//g<Left><Left>]])

-- easy formatting
vim.keymap.set("n", "==", vim.lsp.buf.format)

-- multiline editing
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<Tab>", "<Nop>")

-- window splitting
vim.keymap.set("n", "<leader>v", "<C-w>v")
vim.keymap.set("n", "<leader>b", "<C-w>s")

-- window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- window moving
vim.keymap.set("n", "<leader>H", "<C-w>H")
vim.keymap.set("n", "<leader>J", "<C-w>J")
vim.keymap.set("n", "<leader>K", "<C-w>K")
vim.keymap.set("n", "<leader>L", "<C-w>L")

-- window resizing
vim.keymap.set("n", "<C-w>h", [[:vertical resize +5<Enter>]])
vim.keymap.set("n", "<C-w>j", [[:resize +5<Enter>]])
vim.keymap.set("n", "<C-w>k", [[:resize -5<Enter>]])
vim.keymap.set("n", "<C-w>l", [[:vertical resize -5<Enter>]])
