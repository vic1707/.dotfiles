return {
	{
		'ThePrimeagen/harpoon',
		branch = 'harpoon2',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			require('harpoon').setup()
			local harpoon = require('harpoon')
			local ui = require('harpoon.ui')

			vim.keymap.set('n', '<leader>ha', function()
				harpoon:list():append()
			end, { desc = '[H]arpoon [A]dd' })
			vim.keymap.set('n', '<leader>hm', function()
				ui:toggle_quick_menu(harpoon:list())
			end, { desc = '[H]arpoon [M]enu' })

			for i = 1, 5 do
				vim.keymap.set('n', string.format('<leader>%s', i), function()
					ui.nav_file(i)
				end, { desc = string.format('[]Harpoon Navigate to file [%s]', i) })
			end
		end,
	},
}
