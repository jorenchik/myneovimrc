vim.g.mapleader = "\\"

local defaults = {
	icons = {
		dap = {
			Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
			Breakpoint = " ",
			BreakpointCondition = " ",
			BreakpointRejected = { " ", "DiagnosticError" },
			LogPoint = ".>",
		},
		diagnostics = {
			Error = " ",
			Warn = " ",
			Hint = " ",
			Info = " ",
		},
		git = {
			added = " ",
			modified = " ",
			removed = " ",
		},
		kinds = {
			Array = " ",
			Boolean = " ",
			Class = " ",
			Color = " ",
			Constant = " ",
			Constructor = " ",
			Copilot = " ",
			Enum = " ",
			EnumMember = " ",
			Event = " ",
			Field = " ",
			File = " ",
			Folder = " ",
			Function = " ",
			Interface = " ",
			Key = " ",
			Keyword = " ",
			Method = " ",
			Module = " ",
			Namespace = " ",
			Null = " ",
			Number = " ",
			Object = " ",
			Operator = " ",
			Package = " ",
			Property = " ",
			Reference = " ",
			Snippet = " ",
			String = " ",
			Struct = " ",
			Text = " ",
			TypeParameter = " ",
			Unit = " ",
			Value = " ",
			Variable = " ",
		},
	},
}

function find_project_root()
	local dir = vim.fn.expand("%:p:h")
	while dir ~= "/" do
		if vim.fn.filereadable(dir .. "/.latexconfig") == 1 then
			return dir
		end
		dir = vim.fn.fnamemodify(dir, ":h")
	end
	return nil
end

function compile_latex_from_config()
	vim.notify = require("notify")
	local project_root = find_project_root()
	if project_root == nil then
		vim.notify("No .latexconfig found")
		return
	end

	local config_path = project_root .. "/.latexconfig"
	local entry_file = "index.tex"
	-- local output_directory = "target"
	local options = "-shell-escape -interaction=nonstopmode -output-directory=" .. project_root .. "/target"

	for line in io.lines(config_path) do
		if line:match("^entry=") then
			entry_file = line:sub(7)
		elseif line:match("^options=") then
			options = line:sub(9)
		end
	end

	local compile_command = string.format("xelatex %s %s", options, project_root .. "/" .. entry_file)
	vim.notify("Compiling...")

	local job_id = vim.fn.jobstart(compile_command, {
		on_exit = function(j, return_val)
			if return_val == 0 then
				vim.notify("Compilation Successful")
			else
				vim.notify("Compilation Failed")
			end
		end,
	})
end

require("config.lazy")
require("config.keymaps")
require("config.set")
require("plugins.formatter")

return defaults
