-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal vim.g.have_nerd_font = true

-- [[ Setting options ]]
require("options")

-- [[ Basic Keymaps ]]
require("keymaps")

-- [[ Install `lazy.nvim` plugin manager ]]
require("lazy-bootstrap")

-- [[ Configure and install plugins ]]
require("lazy-plugins")

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

vim.opt.fillchars = { eob = " " }

-- disable defaults
local default_providers = {
	"node",
	"perl",
	"python3",
	"ruby",
}
for _, provider in ipairs(default_providers) do
	vim.g["loaded_" .. provider .. "_provider"] = 0
end

vim.g.python3_host_prog = "/home/joaov/.nix-profile/bin/python3"

-- Set different shiftwidth values for different file types
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "lua" },
	callback = function()
		vim.opt.shiftwidth = 2 -- Set shiftwidth to 2 for Lua
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "python" },
	callback = function()
		vim.opt.shiftwidth = 4 -- Set shiftwidth to 4 for Python
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "javascript", "typescript" },
	callback = function()
		vim.opt.shiftwidth = 2 -- Set shiftwidth to 2 for JavaScript and TypeScript
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "java" },
	callback = function()
		vim.opt.shiftwidth = 4 -- Set shiftwidth to 4 for Java
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "go" },
	callback = function()
		vim.opt.shiftwidth = 4 -- Set shiftwidth to 4 for Go
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "svelte" },
	callback = function()
		vim.opt.shiftwidth = 2 -- Set shiftwidth to 2 for Svelte
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "nix" },
	callback = function()
		vim.opt.shiftwidth = 2 -- Set shiftwidth to 2 for Nix
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "zig" },
	callback = function()
		vim.opt.shiftwidth = 4 -- Set shiftwidth to 4 for Zig
	end,
})
