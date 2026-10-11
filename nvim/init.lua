-- Leader has to be set before any plugin or keymap is loaded.
vim.g.mapleader = " "

require("anton.options")
require("anton.keymaps")
require("anton.lazy")
