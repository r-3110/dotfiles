---@type vim.lsp.Config
return {
	detached = false,
	-- lazy-load schemastore when needed
	before_init = function(_, new_config)
		---@diagnostic disable-next-line: inject-field
		new_config.settings.json.schemas = new_config.settings.json.schemas or {}
		---@module "schemastore"
		vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
	end,
	settings = {
		json = {
			format = {
				enable = true,
			},
			validate = { enable = true },
		},
	},
}
