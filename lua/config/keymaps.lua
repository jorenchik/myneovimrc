local wk = require("which-key")

-- which key labels
wk.register({
	["f"] = { name = "+fuzzy finder" },
	["e"] = { name = "+explore" },
	["t"] = { name = "+todo/fix/fixme" },
	["x"] = { name = "+todo/fix/fixme (trouble)" },
	["c"] = { name = "+code" },
	["u"] = { name = "+colorscheme" },
	["s"] = { ["c"] = {
		name = "noice",
	}, name = "+search" },
	["v"] = {
		["c"] = {
			name = "code",
		},
		["w"] = {
			name = "workspace",
		},
		["r"] = {
			name = "names",
		},
		name = "+vim",
	},
	["g"] = { name = "+git" },
	["b"] = { name = "+buffers" },
	["w"] = { name = "+windows" },
}, { prefix = "<leader>" })

-- code
vim.keymap.set("n", "<Leader>cm", "<cmd>Mason<cr>", { desc = "mason" })
vim.keymap.set(
	"v",
	"<leader>cf",
	"<cmd>'<,'>Neoformat<cr>",
	{ desc = "Format the selection", noremap = true, silent = true }
)
vim.keymap.set("n", "<Leader>cf", "<cmd>Neoformat<cr>", { desc = "Format the buffer" })
vim.keymap.set("n", "<Leader><F3>", "<cmd>Neoformat<cr>", { desc = "Format the buffer" })
vim.keymap.set("n", "<Leader>cc", "<cmd>:Cheatsheet<cr>", { desc = "VIM cheatsheet" })

-- Neotree
vim.keymap.set("n", "<Leader>ex", "<cmd>Neotree toggle<cr>", { desc = "Tree (current directory)" })

-- buffers
vim.keymap.set("n", "<C-s>", "<cmd>:w<cr>", { desc = "Write to the buffer" })
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

-- windows
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
vim.keymap.set("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
vim.keymap.set("n", "<leader>-", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>|", "<C-W>v", { desc = "Split window right", remap = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- terminal
vim.keymap.set("n", "<leader>vt", "<cmd>:tab term<cr>", { desc = "Terminal" })
vim.keymap.set("t", "<C-x>", "<C-Bslash><C-n>", { desc = "Close terminal", remap = true })

-- Explore
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- Move lines in visual
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Join staying in the same position
vim.keymap.set("n", "J", "mzJ`z")

-- Centered movement
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Smart copy-delete
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])
vim.keymap.set("x", "<leader>p", [["_dP]])
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Escape and save
vim.keymap.set("i", "<C-s>", "<Esc><cmd>w<CR>")
