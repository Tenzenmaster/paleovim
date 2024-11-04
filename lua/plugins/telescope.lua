return {
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
    vim.keymap.set('n', '<leader>sk', builtin.keymaps)
    vim.keymap.set('n', '<leader>st', builtin.builtin)
    vim.keymap.set('n', '<leader>sw', builtin.grep_string)
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics)
    vim.keymap.set('n', '<leader>sr', builtin.resume)
    vim.keymap.set('n', '<leader>so', builtin.oldfiles)
    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files({ cwd = vim.fn.stdpath('config') })
    end)
  end,
}
