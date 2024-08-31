-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local get_servers_config = function()
	return {
		angularls = {}, -- Angular
		astro = {}, -- Astro
		bashls = {}, -- Bash
		clangd = {}, -- C, C++, Objective-C
		cssls = {}, -- CSS
		dockerls = {}, -- Dockerfile
		-- TODO: `EslintFixAll` on save
		eslint = {}, -- JavaScript, TypeScript, etc.
		gopls = {}, -- Go
		html = { -- HTML, Twig, Handlebars
			filetypes = {
				'html',
				'twig',
				'hbs',
			},
		},
		intelephense = {}, -- PHP -- Hate that shit
		jsonls = { -- JSON
			json = {
				-- Enable json schemas
				schemas = require('schemastore').json.schemas(),
				validate = { enable = true },
			},
		},
		lua_ls = { -- Lua
			Lua = {
				workspace = {
					checkThirdParty = false,
				},
				telemetry = {
					enable = false,
				},
			},
		},
		ocamllsp = {}, -- OCaml
		pyright = {}, -- Python
		rust_analyzer = {}, -- Rust -- configured by rust-tools
		sqlls = {}, -- SQL
		stylelint_lsp = {}, -- CSS, SCSS, etc.
		svelte = {}, -- Svelte
		taplo = {}, -- TOML
		tsserver = {}, -- JavaScript, TypeScript, etc.
		zls = {}, -- Zig
	}
end

local mason_tools = {
	'beautysh', -- Shell
	'editorconfig-checker', -- EditorConfig
	'flake8', -- Python
	'luacheck', -- Lua
	'prettier', -- JavaScript, TypeScript, HTML, CSS, JSON, YAML, Markdown, Vue, Svelte, GraphQL, etc.
	'stylelint', -- CSS, SCSS, etc.
	'stylua', -- Lua
	'shellcheck', -- Shell
}

return {
	{
		-- NOTE: This is where your plugins related to LSP can be installed.
		--  The configuration is done below. Search for lspconfig to find it below.
		-- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			{ 'williamboman/mason.nvim', config = true },
			{
				'williamboman/mason-lspconfig.nvim',
				dependencies = {
					-- Json Schemas
					'b0o/schemastore.nvim',
				},
			},

			-- Automatically install other mason tools
			{
				'WhoIsSethDaniel/mason-tool-installer.nvim',
				opts = {
					ensure_installed = mason_tools,
					-- if set to true this will check each tool for updates. If updates
					-- are available the tool will be updated.
					auto_update = true,
					-- Only attempt to install if 'debounce_hours' number of hours has
					-- elapsed since the last time Neovim was started.
					debounce_hours = 24,
				},
			},

			-- Useful status updates for LSP
			{ 'j-hui/fidget.nvim', tag = 'legacy' },

			-- Additional lua configuration, makes nvim stuff amazing!
			{ 'folke/neodev.nvim', opts = {} },
		},
		config = function()
			-- [[ Configure LSP ]]
			--  This function gets run when an LSP connects to a particular buffer.
			local on_attach = function(_, bufnr)
				-- NOTE: Remember that lua is a real programming language, and as such it is possible
				-- to define small helper and utility functions so you don't have to repeat yourself
				-- many times.
				--
				-- In this case, we create a function that lets us more easily define mappings specific
				-- for LSP related items. It sets the mode, buffer and description for us each time.
				local nmap = function(keys, func, desc)
					if desc then
						desc = 'LSP: ' .. desc
					end

					vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
				end

				nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
				nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

				nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
				nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
				nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
				nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
				nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
				nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

				-- See `:help K` for why this keymap
				nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
				nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

				-- Lesser used LSP functionality
				nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
				nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
				nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
				nmap('<leader>wl', function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, '[W]orkspace [L]ist Folders')

				-- Create a command `:Format` local to the LSP buffer
				vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
					vim.lsp.buf.format()
				end, { desc = 'Format current buffer with LSP' })
			end

			-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

			-- Ensure the servers above are installed
			local mason_lspconfig = require('mason-lspconfig')

			local servers = get_servers_config()

			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(servers),
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					require('lspconfig')[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = servers[server_name],
						filetypes = (servers[server_name] or {}).filetypes,
					})
				end,
			})
		end,
	},

	{
		'simrat39/rust-tools.nvim',
		opts = {
			tools = {
				runnables = {
					use_telescope = true,
				},
				inlay_hints = {
					auto = true,
					show_parameter_hints = false,
					parameter_hints_prefix = '',
					other_hints_prefix = '',
				},
			},

			-- all the opts to send to nvim-lspconfig
			-- these override the defaults set by rust-tools.nvim
			-- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
			server = {
				settings = {
					-- to enable rust-analyzer settings visit:
					-- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
					['rust-analyzer'] = {
						-- enable clippy on save
						checkOnSave = {
							command = 'clippy',
						},
					},
				},
			},
		},
	},
}
