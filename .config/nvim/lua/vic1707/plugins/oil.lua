return {
  -- Buffer like file explorer
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup()
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open current directory' })
  end,
}
