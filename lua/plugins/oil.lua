return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    view_options = {
      show_hidden = true,
    },
    skip_confirm_for_simple_edits = true,
    prompt_save_on_select_new_entry = false,
    delete_to_trash = true,
  },
  config = function(_, opts)
    require('oil').setup(opts)
    vim.keymap.set('n', '-', '<cmd>Oil<cr>')
  end,
}
