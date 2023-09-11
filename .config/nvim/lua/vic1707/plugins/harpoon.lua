return {
  {
    'ThePrimeagen/harpoon',
    config = function()
      require('harpoon').setup()
      ui = require('harpoon.ui')
      mark = require('harpoon.mark')

      vim.keymap.set('n', '<leader>ha', mark.add_file, { desc = '[H]arpoon [A]dd File' })
      vim.keymap.set('n', '<leader>hm', ui.toggle_quick_menu, { desc = '[H]arpoon [M]enu' })

      for i = 1, 5 do
        vim.keymap.set('n', string.format('<leader>%s', i), function()
          ui.nav_file(i)
        end, { desc = string.format('[]Harpoon Navigate to file [%s]', i) })
      end
    end,
  },
}
