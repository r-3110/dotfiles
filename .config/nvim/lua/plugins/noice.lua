--@see https://github.com/folke/noice.nvim

---@type LazyPluginSpec[]
return {
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			{
				"rcarriga/nvim-notify",
				config = function()
					---@module "notify"
					local notify = require("notify")

					---@type notify.Config
					---@diagnostic disable-next-line: missing-fields
					local notifyConfig = {
						stages = "fade_in_slide_out",
						timeout = 1500,
						background_colour = "#1e1e2e",
						top_down = false,
					}

					notify.setup(notifyConfig)

					vim.notify = notify

					-- 通知を強制的に閉じる
					vim.keymap.set("n", "<leader>dn", function()
						notify.dismiss({ silent = true, pending = false })
					end, { desc = "Dismiss notifications" })
				end,
			},
		},
		config = function()
			---@module "noice"
			local noice = require("noice")

			---@type NoiceConfig
			local noiceConfig = {
				---@type NoicePresets
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = true,
				},
				notify = {
					enabled = false,
				},
				views = {
					hover = {
						size = {
							--- 内容が大きすぎると邪魔なのでmax_heightを設定
							max_height = 10,
						},
					},
				},
			}
			noice.setup(noiceConfig)
		end,
	},
}
