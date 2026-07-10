---@type vim.lsp.Config
return {
	cmd = { "kakehashi" },
	filetypes = { "markdown" },
	detached = false,
	init_options = {
		autoInstall = true,
		languageServers = {
			pyright = {
				cmd = { "pyright-langserver", "--stdio" },
				languages = { "python" },
			},
			["lua-language-server"] = {
				cmd = { "lua-language-server" },
				languages = { "lua" },
			},
			vtsls = {
				cmd = { "vtsls", "--stdio" },
				languages = {
					"typescript",
					"javascript",
					"typescriptreact",
					"javascriptreact",
					"ts",
					"tsx",
					"js",
					"jsx",
				},
			},
			gopls = {
				cmd = { "gopls" },
				languages = { "go" },
			},
			["bash-language-server"] = {
				cmd = { "bash-language-server", "start" },
				languages = { "sh", "bash", "zsh" },
			},
			jsonls = {
				cmd = { "vscode-json-language-server", "--stdio" },
				languages = { "json", "jsonc" },
			},
		},
	},
}
