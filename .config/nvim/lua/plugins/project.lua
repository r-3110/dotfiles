-- @see https://github.com/coffebar/neovim-project

---@type LazyPluginSpec
return {
	"coffebar/neovim-project",
	---@module "neovim-project"
	--- @type ProjectOptions
	opts = {
		projects = { -- define project roots
			"~/workspace/*",
			"~/workspace/playground/*",
			"~/dotfiles",
		},
		picker = {
			type = "telescope", -- or "fzf-lua"
		},
	},
	init = function()
		-- enable saving the state of plugins in the session
		vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
	end,
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		-- optional picker
		{ "nvim-telescope/telescope.nvim" },
		-- optional picker
		-- { "ibhagwan/fzf-lua" },
		{ "Shatur/neovim-session-manager" },
	},
	lazy = false,
	priority = 100,
}
