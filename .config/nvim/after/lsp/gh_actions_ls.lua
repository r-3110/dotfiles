local file_types = require("utils.filetype")

---@type vim.lsp.Config
return {
	filetypes = { file_types.my_filetypes.gh },
}
