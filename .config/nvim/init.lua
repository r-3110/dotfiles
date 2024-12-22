-- @see https://www.lazyvim.org/configuration
if vim.g.vscode then
	require("config.vscode")
else
	require("config.lazy")
end
