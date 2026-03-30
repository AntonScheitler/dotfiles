local lsp_zero = require('lsp-zero')

lsp_zero.extend_lspconfig()

-- lsp_attach is where you enable features that only work
-- if there is a language server active in the file
lsp_zero.on_attach(function(client, bufnr)
  -- see :help lsp-zero-keybindings
  -- to learn the available actions
  lsp_zero.default_keymaps({buffer = bufnr})

  -- Enable formatting on attach for servers that support it
  if client.server_capabilities.documentFormattingProvider then
    require("lsp-format").on_attach(client, bufnr)
  end
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'lua_ls', 'eslint', 'clangd', 'pyright', 'rust_analyzer', 'texlab', 'gopls'},
  handlers = {
    lsp_zero.default_setup,
    lua_ls = function()
      local lua_opts = lsp_zero.get_lua_opts({
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim' }
            }
          }
        }
      })
      require('lspconfig').lua_ls.setup(lua_opts)
    end,
  }
})

-- Configure servers that are not managed by mason
require('lspconfig').dartls.setup({})

require('lspconfig').arduino_language_server.setup({
    cmd = {
        "arduino-language-server",
        "-cli-config", "/home/anton/.arduino15/arduino-cli.yaml",
        "-fqbn", "arduino:avr:uno"
    }
})

-- nvim-cmp setup
lsp_zero.extend_cmp()

local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    -- `Enter` key to confirm completion
    ['<CR>'] = cmp.mapping.confirm({select = false}),

    -- Ctrl+Space to trigger completion menu
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<tab>'] = cmp.mapping.confirm({select = true}),

    -- Navigate between snippet placeholder
    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
    ['<C-b>'] = cmp_action.luasnip_jump_backward(),

    -- Scroll up and down in the completion documentation
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
  }),
  sources = {
    {name = 'nvim_lsp'},
    {name = 'luasnip'},
  }
})

require("lsp-format").setup {}
