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
		["%.env.*"] = "dotenv",
		[".*/.github/workflows/.*%.ya?ml"] = "yaml.ghaction",
		[".*compose.*%.ya?ml"] = "yaml.docker-compose",
		[".*/.*tsconfig.*%.json"] = "json.tsconfig",
		[".*%.yml"] = checkCfn,
		[".*%.yaml"] = checkCfn,
		["%w+%.yml"] = "yaml",
		["[Dd]ockerfile.*"] = "dockerfile",
	},
	filename = {
		["venv-selector.lua"] = "lua",
	},
})
