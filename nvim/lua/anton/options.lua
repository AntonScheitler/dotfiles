local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.guicursor = ""
opt.termguicolors = true
opt.signcolumn = "yes"
opt.scrolloff = 8
opt.wrap = false
opt.textwidth = 120

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true

-- Search
opt.hlsearch = false
opt.incsearch = false

-- Files
opt.swapfile = false
opt.updatetime = 50

vim.diagnostic.config({ virtual_text = true })
