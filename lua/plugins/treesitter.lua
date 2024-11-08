return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  opts = {
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = false },
    ensure_installed = {
      'lua', 'luadoc', 'vim', 'vimdoc',
      'c', 'cpp', 'cmake', 'make', 'markdown',
      'c_sharp', 'java', 'rust', 'toml', 'bash', 'xml', 'wgsl',
      'gitattributes', 'gitcommit', 'gitignore', 'git_rebase', 'git_config',
      'nix', 'zig',
    },
  },
}
