--@ see https://github.com/vim-jp/nvimdoc-ja

---@type LazyPluginSpec
return {
	"vim-jp/nvimdoc-ja",
	ft = { "<F1>", "<Help>" },
	event = { "CmdlineEnter" },
}
