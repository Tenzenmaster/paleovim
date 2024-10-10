vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = false
vim.opt.scrolloff = 0

vim.keymap.set('n', '<esc>', '<cmd>noh<cr>')
vim.keymap.set('n', '<space>', '<nop>')
vim.keymap.set('n', '-', '<cmd>Ex<cr>')

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system {
    'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath
  }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  install = { colorscheme = { 'default' } },
  checker = { enabled = false },
  spec = {
    { 'tpope/vim-sleuth' },
    {
      'nvim-treesitter/nvim-treesitter',
      build = ':TSUpdate',
      main = 'nvim-treesitter.configs',
      opts = {
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = false },
      },
    },
    {
      'neovim/nvim-lspconfig',
      dependencies = {
        { 'williamboman/mason.nvim', config = true },
        'williamboman/mason-lspconfig.nvim',
        'WhoIsSethDaniel/mason-tool-installer.nvim',
      },
      config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        local servers = {
          lua_ls = {},
          clangd = {},
          rust_analyzer = {},
          zls = {},
          jdtls = {},
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
      end,
    },
    {
      'folke/lazydev.nvim',
      dependencies = {
        { 'Bilal2453/luvit-meta', lazy = true },
      },
      ft = 'lua',
      opts = {
        library = {
          { path = 'luvit-meta/library', words = { 'vim%.uv' } },
        },
      },
    },
    {
      'lewis6991/gitsigns.nvim',
      opts = {
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        }
      },
    },
    {
      'nvim-telescope/telescope.nvim',
      dependencies = {
        { 'nvim-lua/plenary.nvim', },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      },
      config = function()
        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>sf', builtin.find_files)
        vim.keymap.set('n', '<leader>sg', builtin.live_grep)
        vim.keymap.set('n', '<leader>sb', builtin.buffers)
        vim.keymap.set('n', '<leader>sh', builtin.help_tags)
        vim.keymap.set('n', '<leader>sn', function()
          builtin.find_files({ cwd = vim.fn.stdpath('config') }) end)
      end,
    }
  },
})

-- vim: ts=2 sts=2 sw=2 et
