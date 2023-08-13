vim.api.nvim_create_autocmd({ "BufWritePre" }, {
	pattern = { "*" },
	callback = function()
		vim.cmd("Neoformat")
	end,
})

vim.g.neoformat_python_black = {
	exe = "black",
	args = { "-l 79" },
	replace = 1,
	env = { "DEBUG=1" },
	valid_exit_codes = { 0, 23 },
}

vim.g.neoformat_html_enabled = { "djlint" }
vim.g.neoformat_python_enabled = { "black" }

return {}
