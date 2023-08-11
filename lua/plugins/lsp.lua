return {
	{
		{
			"VonHeikemen/lsp-zero.nvim",
			branch = "v2.x",
			dependencies = {
				-- LSP Support
				{ "neovim/nvim-lspconfig" },
				{ "williamboman/mason.nvim" },
				{ "williamboman/mason-lspconfig.nvim" },

				-- Autocompletion
				{ "hrsh7th/nvim-cmp" }, -- Required
				{ "hrsh7th/cmp-nvim-lsp" }, -- Required
				{ "L3MON4D3/LuaSnip" }, -- Required
			},
			config = function()
				local lsp = require("lsp-zero").preset({})

				lsp.on_attach(function(client, bufnr)
					-- see :help lsp-zero-keybindings
					-- to learn the available actions
					lsp.default_keymaps({ buffer = bufnr })
				end)

				lsp.nvim_workspace()

				local cmp = require("cmp")
				local cmp_select = { behavior = cmp.SelectBehavior.Select }
				local cmp_mappings = lsp.defaults.cmp_mappings({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
				})

				lsp.setup_nvim_cmp({
					mapping = cmp_mappings,
				})


				-- (Optional) Configure lua language server for neovim
				-- require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())

				lsp.setup()
			end,
		},
	},
	-- {
	-- 	"AckslD/swenv.nvim",
	-- 	config = function()
	-- 		require("swenv").setup({
	-- 			-- Should return a list of tables with a `name` and a `path` entry each.
	-- 			-- Gets the argument `venvs_path` set below.
	-- 			-- By default just lists the entries in `venvs_path`.
	-- 			get_venvs = function(venvs_path)
	-- 				return require("swenv.api").get_venvs(venvs_path)
	-- 			end,
	-- 			-- Path passed to `get_venvs`.
	-- 			venvs_path = vim.fn.expand("~/.pyenv/"),
	-- 			-- Something to do after setting an environment, for example call vim.cmd.LspRestart
	-- 			post_set_venv = nil,
	-- 		})
	-- 	end,
	-- },
}
