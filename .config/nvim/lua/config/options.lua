---@param path string
---@param bufnr integer
---@return string
local checkCfn = function(path, bufnr)
	for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, 10, false)) do
		if line:match("AWSTemplateFormatVersion") then
			return "yaml.cfn"
		end
	end
	return "yaml"
end

vim.filetype.add({
	extension = {
		yml = "yaml",
	},
	pattern = {
		[".env.*"] = "dotenv",
		["%.env.*"] = "dotenv",
		["%.env"] = "dotenv",
		[".*/.github/workflows/.*%.yml"] = "yaml.ghaction",
		[".*/.github/workflows/.*%.yaml"] = "yaml.ghaction",
		["%w+%.yml"] = "yaml",
		[".*%.yml"] = checkCfn,
		[".*%.yaml"] = checkCfn,
		["Dockerfile.*"] = "dockerfile",
		["Dockerfile"] = "dockerfile",
		["dockerfile.*"] = "dockerfile",
		["dockerfile"] = "dockerfile",
	},
	filename = {
		["venv-selector.lua"] = "lua",
	},
})
