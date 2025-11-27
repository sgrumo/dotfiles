return {
  'tiagovla/tokyodark.nvim',
  opts = {
    custom_highlights = {
      NeoTreeGitModified = { fg = '#9aced6' },
    },
  },
  config = function(_, opts)
    require('tokyodark').setup(opts) -- calling setup is optional
    vim.cmd [[colorscheme tokyodark]]
  end,
}
