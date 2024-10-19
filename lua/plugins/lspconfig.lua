return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
    },
    config = function()
      local telescope = require('telescope.builtin')

      vim.keymap.set('n', 'gd', telescope.lsp_definitions)
      vim.keymap.set('n', 'gr', telescope.lsp_references)
      vim.keymap.set('n', 'gI', telescope.lsp_implementations)
      vim.keymap.set('n', '<leader>D', telescope.lsp_type_definitions)
      vim.keymap.set('n', '<leader>ds', telescope.lsp_document_symbols)
      vim.keymap.set('n', '<leader>ws', telescope.lsp_dynamic_workspace_symbols)
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local servers = {
        lua_ls = {},
        clangd = {},
        rust_analyzer = {},
        zls = {},
        -- jdtls = {},
        omnisharp = {
          cmd = { vim.fn.stdpath('data') .. '/mason/bin/omnisharp' },
        },
        ols = {},
      }
      local ensure_installed = vim.tbl_keys(servers)
      require('mason-tool-installer').setup({ ensure_installed = ensure_installed })
      require('mason-lspconfig').setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend(
              'force', {}, capabilities, server.capabilities or {}
            )
            require('lspconfig')[server_name].setup(server)
          end,
        },
      })
      require('lspconfig').gdscript.setup({})
      require('lspconfig').gdshader_lsp.setup({})
    end,
  },
}
