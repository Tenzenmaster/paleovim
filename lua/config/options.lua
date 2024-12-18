vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.showmode = false
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
vim.opt.scrolloff = 5
vim.opt.guicursor = 'n-v-c-i:block'
vim.opt.shm:append("I")
vim.opt.cursorline = true
vim.opt.cindent = true
vim.opt.gdefault = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.laststatus = 3

vim.keymap.set('n', '<C-h>', '<C-w><C-h>')
vim.keymap.set('n', '<C-j>', '<C-w><C-j>')
vim.keymap.set('n', '<C-k>', '<C-w><C-k>')
vim.keymap.set('n', '<C-l>', '<C-w><C-l>')

vim.keymap.set('n', '<space>', '<nop>')
vim.keymap.set('n', '<leader>k', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>di', function()
  vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end)
vim.keymap.set('n', '-', '<cmd>Ex<cr>')
vim.keymap.set('t', '<esc>', '<C-\\><C-n>')

vim.diagnostic.enable(false)
vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = true,
})

vim.api.nvim_create_autocmd('CmdlineEnter', {
  callback = function()
    vim.opt.hlsearch = true
  end
})

vim.api.nvim_create_autocmd('CmdlineLeave', {
  callback = function()
    vim.opt.hlsearch = false
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'html', 'css' },
  callback = function()
    vim.opt.shiftwidth = 2
    vim.opt.tabstop = 2
    vim.opt.softtabstop = 2
    vim.opt.expandtab = true
  end,
})
