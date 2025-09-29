---@class FiletypeUtils
---@field checkCfn fun(path: string, bufnr: integer): string
---@field my_filetypes table<string, string>
---@field my_filetype_rules table<string, {regex: string, icon: string, color: string}>
local M = {}

M.my_filetypes = {
	dockerfile = "dockerfile",
	["docker-compose"] = "yaml.docker-compose",
	gh = "yaml.ghaction",
	tsconfig = "tsconfig",
}

M.my_filetype_rules = {
	[M.my_filetypes.dockerfile] = {
		regex = "[Dd]ockerfile.*",
		icon = "󰡨",
		color = "#458EE6",
	},
	[M.my_filetypes["docker-compose"]] = {
		regex = ".*compose.*%.ya?ml",
		icon = "",
		color = "#FF8DA1",
	},
	[M.my_filetypes.gh] = {
		regex = ".*%.github/workflows/.*%.ya?ml",
		icon = "",
		color = "#7E57C2",
	},
	[M.my_filetypes.tsconfig] = {
		regex = ".*tsconfig.*%.json",
		icon = "",
		color = "#2D79C7",
	},
}

-- [[
-- filetypeを返す関数
-- yamlファイルの中身を確認し、CloudFormationテンプレートなら"yaml.cfn"を返す。
---@param path string
---@param bufnr integer
---@return string
M.checkCfn = function(path, bufnr)
	for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 0, 10, false)) do
		if line:match("AWSTemplateFormatVersion") then
			return "yaml.cfn"
		end
	end
	return "yaml"
end

return M
