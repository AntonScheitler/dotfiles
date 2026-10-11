return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "lukas-reineke/lsp-format.nvim",
  },
  config = function()
    require("lsp-format").setup({})

    -- Settings shared by every server
    vim.lsp.config("*", {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })

    -- Per-server settings
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            checkThirdParty = false,
            library = { vim.env.VIMRUNTIME .. "/lua" },
          },
          telemetry = { enable = false },
        },
      },
    })

    vim.lsp.config("arduino_language_server", {
      cmd = {
        "arduino-language-server",
        "-cli-config", vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
        "-fqbn", "arduino:avr:uno",
      },
    })

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then return end

        local function map(mode, lhs, rhs)
          vim.keymap.set(mode, lhs, rhs, { buffer = event.buf })
        end

        map("n", "K", vim.lsp.buf.hover)
        map("n", "gd", vim.lsp.buf.definition)
        map("n", "gD", vim.lsp.buf.declaration)
        map("n", "gi", vim.lsp.buf.implementation)
        map("n", "go", vim.lsp.buf.type_definition)
        map("n", "gr", vim.lsp.buf.references)
        map("n", "gs", vim.lsp.buf.signature_help)
        map("n", "gl", vim.diagnostic.open_float)
        map("n", "<F2>", vim.lsp.buf.rename)
        map({ "n", "x" }, "<F3>", function() vim.lsp.buf.format({ async = true }) end)
        map({ "n", "x" }, "<F4>", vim.lsp.buf.code_action)

        -- Format on save for servers that can
        if client.server_capabilities.documentFormattingProvider then
          require("lsp-format").on_attach(client, event.buf)
        end
      end,
    })

    -- Mason installs these and auto-enables every server it has installed.
    require("mason").setup({})
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "eslint", "clangd", "pyright", "rust_analyzer", "texlab", "gopls" },
    })

    -- Servers installed outside of mason
    vim.lsp.enable({ "dartls", "arduino_language_server" })
  end,
}
