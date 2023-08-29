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
				{ "rafamadriz/friendly-snippets" },
				{ "saadparwaiz1/cmp_luasnip" },

				-- Autocompletion
				{ "hrsh7th/nvim-cmp" },
				{ "hrsh7th/cmp-nvim-lsp" },
				{ "L3MON4D3/LuaSnip" },
			},
			config = function()
				local lsp = require("lsp-zero").preset({
					manage_nvim_cmp = { set_sources = "recommended" },
				})

				lsp.on_attach(function(_, bufnr)
					lsp.default_keymaps({ buffer = bufnr })
				end)

				lsp.nvim_workspace()

				local cmp_action = require("lsp-zero").cmp_action()

				require("luasnip.loaders.from_vscode").lazy_load()
				require("luasnip.loaders.from_snipmate").lazy_load()

				local cmp = require("cmp")
				local cmp_select = { behavior = cmp.SelectBehavior.Select }
				local cmp_mappings = lsp.defaults.cmp_mappings({
					["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
					["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-f>"] = cmp_action.luasnip_jump_forward(),
					["<C-b>"] = cmp_action.luasnip_jump_backward(),
				})

				require("luasnip").filetype_extend("html", { "djangohtml" })
				require("luasnip").filetype_extend("htmldjango", { "html" })

				cmp.setup({
					sources = {
						{ name = "nvim_lsp" },
						{ name = "luasnip" },
					},
					mapping = cmp_mappings,
				})

				lsp.on_attach(function(_, bufnr)
					local opts = { buffer = bufnr, remap = false }

					vim.keymap.set("n", "gd", function()
						vim.lsp.buf.definition()
					end, { unpack(opts), desc = "Go to definition" })

					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover()
					end, { unpack(opts), desc = "Show information" })

					vim.keymap.set("n", "<leader>vws", function()
						vim.lsp.buf.workspace_symbol()
					end, { unpack(opts), desc = "Workspace symbol" })

					vim.keymap.set("n", "<leader>vd", function()
						vim.diagnostic.open_float()
					end, { unpack(opts), desc = "Open floating diagnostic" })

					vim.keymap.set("n", "[d", function()
						vim.diagnostic.goto_next()
					end, { unpack(opts), desc = "Go to next" })

					vim.keymap.set("n", "]d", function()
						vim.diagnostic.goto_prev()
					end, { unpack(opts), desc = "Go to previous" })

					vim.keymap.set("n", "<leader>vca", function()
						vim.lsp.buf.code_action()
					end, { unpack(opts), desc = "action" })

					vim.keymap.set("n", "<leader>vrr", function()
						vim.lsp.buf.references()
					end, { unpack(opts), desc = "Show references" })

					vim.keymap.set("n", "<leader>vrn", function()
						vim.lsp.buf.rename()
					end, { unpack(opts), desc = "Rename" })

					vim.keymap.set("i", "<C-h>", function()
						vim.lsp.buf.signature_help()
					end, { unpack(opts), desc = "Signature help" })
				end)

				lsp.setup()
			end,
		},
	},
}
