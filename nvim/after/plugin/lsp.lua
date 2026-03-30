local lsp_zero = require('lsp-zero')

-- Use LspAttach autocommand for keymaps and formatting
-- This is the recommended way in Neovim 0.11+
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    local id = vim.tbl_get(event, 'data', 'client_id')
    local client = id and vim.lsp.get_client_by_id(id)
    if not client then return end

    local bufnr = event.buf

    -- lsp-zero default keymaps
    lsp_zero.default_keymaps({buffer = bufnr})

    -- Enable formatting on attach for servers that support it
    if client.server_capabilities.documentFormattingProvider then
      require("lsp-format").on_attach(client, bufnr)
    end
  end,
})

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'lua_ls', 'eslint', 'clangd', 'pyright', 'rust_analyzer', 'texlab', 'gopls'},
  handlers = {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name)
      vim.lsp.enable(server_name)
    end,

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
      vim.lsp.config('lua_ls', lua_opts)
      vim.lsp.enable('lua_ls')
    end,
  }
})

-- Configure servers that are not managed by mason
vim.lsp.enable('dartls')

vim.lsp.config('arduino_language_server', {
    cmd = {
        "arduino-language-server",
        "-cli-config", "/home/anton/.arduino15/arduino-cli.yaml",
        "-fqbn", "arduino:avr:uno"
    }
})
vim.lsp.enable('arduino_language_server')

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
