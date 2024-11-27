-- @see https://github.com/nvim-neo-tree/neo-tree.nvim
vim.api.nvim_create_user_command("Tree", "Neotree", {})

return {
	{ "nvim-lua/plenary.nvim" },
	{ "nvim-tree/nvim-web-devicons" },
	{ "MunifTanjim/nui.nvim" },

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		opts = {
			filesystem = {
				follow_current_file = { enabled = true },
				hijack_netrw_behavior = "open_current",
				use_libuv_file_watcher = true,
				filtered_items = {
					visible = false, -- デフォルトで隠されているかどうか
					show_hidden_count = true,
					hide_dotfiles = false, -- dotfileを隠すかどうか
					hide_gitignored = false, -- gitignoreされているファイルを隠すかどうか
					never_show = {
						".git",
					},
				},
			},
		},
	},
}
