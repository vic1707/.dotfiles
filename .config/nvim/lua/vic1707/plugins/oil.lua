return {
  -- Buffer like file explorer
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    view_options = {
      show_hidden = true,
      -- This function defines what will never be shown, even when `show_hidden` is set
      is_always_hidden = function(name, _bufnr)
        local to_always_hide = {
          '.DS_Store',
          'Thumbs.db',
        }

        for _, v in ipairs(to_always_hide) do
          if name:match(v) then
            return true
          end
        end
        return false
      end,
    },
  },
  config = function(_, opts)
    require('oil').setup(opts)
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open current directory' })
  end,
}
