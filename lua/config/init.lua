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
	local output_directory = nil
	local output_directory_path = nil
	local options = nil
	local entry_file = "index.tex"

	if vim.fn.filereadable(project_root .. "/.latexconfig") then
		local config_path = project_root .. "/.latexconfig"
		output_directory = "target"

		output_directory_path = project_root .. "/" .. output_directory
		options = "-shell-escape -interaction=nonstopmode -output-directory=" .. output_directory_path

		for line in io.lines(config_path) do
			if line:match("^entry=") then
				entry_file = line:sub(7)
			elseif line:match("^options=") then
				options = line:sub(9)
			end
		end
	else
		vim.notify("No .latexconfig found")
		local entry_file = "index.tex"
		output_directory = "target"
		return
	end

	local output_pdf = output_directory_path .. "/" .. entry_file:gsub(".tex$", ".pdf")
	local initial_timestamp = nil

	-- Check if the output PDF exists and get its timestamp
	if vim.fn.filereadable(output_pdf) == 1 then
		initial_timestamp = vim.fn.getftime(output_pdf)
	end

	local compile_command = string.format("xelatex %s %s", options, project_root .. "/" .. entry_file)
	vim.notify("Compiling...")

	local job_id = vim.fn.jobstart(compile_command, {
		on_exit = function(j, return_val)
			local final_timestamp = vim.fn.getftime(output_pdf)
			vim.notify(compile_command)
			if return_val == 0 then
				vim.notify("Compilation Successful")
			elseif initial_timestamp and final_timestamp > initial_timestamp then
				vim.notify("Compilation finished with warnings")
			else
				vim.notify("Compilation Failed with return value: " .. return_val)
			end
		end,
	})
end

require("config.lazy")
require("config.keymaps")
require("config.set")
require("plugins.formatter")

return defaults
