---@type vim.lsp.Config
return {
	cmd = { "version-lsp" },
	filetypes = { "json", "jsonc", "toml", "gomod", "yaml" },
	root_markers = { ".git" },
	settings = {
		["version-lsp"] = {
			npm = { enabled = true },
			crates = { enabled = true },
			goProxy = { enabled = true },
			pypi = { enabled = true },
			github = { enabled = true },
			pnpmCatalog = { enabled = true },
			jsr = { enabled = true },
			docker = { enabled = true },
		},
	},
}
