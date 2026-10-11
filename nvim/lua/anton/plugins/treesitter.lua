return {
  "nvim-treesitter/nvim-treesitter",
  -- `main` is a rewrite without nvim-treesitter.configs; stay on the classic branch.
  branch = "master",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "c", "python", "javascript", "typescript", "lua", "vim", "vimdoc", "query", "markdown", "go" },
      auto_install = true,
      highlight = { enable = true },
    })
  end,
}
