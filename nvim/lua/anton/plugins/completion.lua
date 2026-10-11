return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- Jump between snippet placeholders, or fall back to the key's normal behaviour.
    local function snippet_jump(direction)
      return cmp.mapping(function(fallback)
        if luasnip.jumpable(direction) then
          luasnip.jump(direction)
        else
          fallback()
        end
      end, { "i", "s" })
    end

    cmp.setup({
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = false }),
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-j>"] = cmp.mapping.select_next_item(),
        ["<C-k>"] = cmp.mapping.select_prev_item(),
        ["<C-f>"] = snippet_jump(1),
        ["<C-b>"] = snippet_jump(-1),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
      }),
      sources = {
        { name = "nvim_lsp" },
      },
    })
  end,
}
