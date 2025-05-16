-- @see https://github.com/iamcco/markdown-preview.nvim

---@type LazyPluginSpec
return {
	"iamcco/markdown-preview.nvim",
	lazy = true,
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function()
		vim.fn["mkdp#util#install"]()
	end,
}
