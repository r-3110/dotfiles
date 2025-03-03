vim.filetype.add({
	extension = {
		yml = "yaml",
	},
	pattern = {
		[".*/.github/workflows/.*%.yml"] = "yaml.ghaction",
	},
})
