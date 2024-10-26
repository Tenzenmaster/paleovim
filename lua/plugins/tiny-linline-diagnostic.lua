return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  cond = false,
  config = function()
    require('tiny-inline-diagnostic').setup()
    vim.diagnostic.config({ virtual_text = false })
  end,
}
