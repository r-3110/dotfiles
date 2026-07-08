-- @see https://github.com/zbirenbaum/copilot.lua

---@module "lazy"
---@type LazyPluginSpec[]
return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		---@module "copilot"
		---@type CopilotConfig
		---@diagnostic disable-next-line: missing-fields
		keys = {
			{
				"<Tab>",
				mode = { "i" },
				function()
					---@module "copilot.suggestion"
					require("copilot.suggestion").accept()
				end,
				desc = "Accept Copilot suggestion",
			},
			{
				"<C-]>",
				mode = { "i" },
				function()
					---@module "copilot.suggestion"
					require("copilot.suggestion").next()
				end,
				desc = "next Copilot suggestion",
			},
			{
				"<C-[",
				mode = { "i" },
				function()
					---@module "copilot.suggestion"
					require("copilot.suggestion").prev()
				end,
				desc = "previous Copilot suggestion",
			},
		},
		---@module "copilot"
		---@type CopilotConfig
		---@diagnostic disable-next-line: missing-fields
		opts = {
			---@diagnostic disable-next-line: missing-fields
			nes = {
				enabled = false,
			},
			---@diagnostic disable-next-line: missing-fields
			suggestion = { enabled = true, auto_trigger = true },
			---@diagnostic disable-next-line: missing-fields
			panel = { enabled = false },
			filetypes = {
				["*"] = true,
			},
			---@diagnostic disable-next-line: missing-fields
			logger = {
				print_log_level = vim.log.levels.OFF,
			},
		},
	},
}
