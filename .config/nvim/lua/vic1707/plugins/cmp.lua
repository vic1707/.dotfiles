return {
	-- Autocompletion
	'hrsh7th/nvim-cmp',
	dependencies = {
		-- Snippet Engine & its associated nvim-cmp source
		{
			'L3MON4D3/LuaSnip',
			dependencies = {
				-- Adds a number of user-friendly snippets
				'rafamadriz/friendly-snippets',
			},
		},
		'saadparwaiz1/cmp_luasnip',

		-- Adds LSP completion capabilities
		'hrsh7th/cmp-nvim-lsp',

		-- Copilot
		{
			'zbirenbaum/copilot-cmp',
			dependencies = {
				{
					'zbirenbaum/copilot.lua',
					opts = {
						suggestion = { enabled = false },
						panel = { enabled = false },
					},
				},
			},
			opts = {},
		},
	},
	config = function()
		-- [[ Configure nvim-cmp ]]
		-- See `:help cmp`
		local cmp = require('cmp')
		local luasnip = require('luasnip')
		require('luasnip.loaders.from_vscode').lazy_load()
		luasnip.config.setup({})

		cmp.setup({
			completion = {
				completeopt = 'menu,menuone,noinsert,noselect',
			},
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				['<C-n>'] = cmp.mapping.select_next_item(),
				['<C-p>'] = cmp.mapping.select_prev_item(),
				['<C-d>'] = cmp.mapping.scroll_docs(-4),
				['<C-f>'] = cmp.mapping.scroll_docs(4),
				['<C-Space>'] = cmp.mapping.complete({}),
				['<CR>'] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Replace,
					select = false,
				}),
				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { 'i', 's' }),
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { 'i', 's' }),
			}),
			sources = {
				{ name = 'copilot' },
				{ name = 'nvim_lsp' },
				{ name = 'luasnip' },
			},
			experimental = {
				ghost_text = true,
			},
		})
	end,
}
