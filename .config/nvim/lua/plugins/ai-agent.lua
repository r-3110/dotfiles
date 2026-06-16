--@see https://github.com/folke/sidekick.nvim

---@module "lazy"
---@type LazyPluginSpec[]
return {
	{
		"folke/sidekick.nvim",
		keys = {
			{
				"<tab>",
				function()
					-- if there is a next edit, jump to it, otherwise apply it if any
					if not require("sidekick").nes_jump_or_apply() then
						return "<Tab>" -- fallback to normal tab
					end
				end,
				expr = true,
				desc = "Goto/Apply Next Edit Suggestion",
			},
			{
				"<c-z>",
				function()
					require("sidekick.cli").toggle()
				end,
				desc = "Sidekick Toggle",
				mode = { "n", "t", "i", "x" },
			},
			{
				"<leader>zz",
				function()
					require("sidekick.cli").toggle()
				end,
				desc = "Sidekick Toggle CLI",
			},
			{
				"<leader>zs",
				function()
					require("sidekick.cli").select()
				end,
				-- Or to select only installed tools:
				-- require("sidekick.cli").select({ filter = { installed = true } })
				desc = "Select CLI",
			},
			{
				"<leader>zd",
				function()
					require("sidekick.cli").close()
				end,
				desc = "Detach a CLI Session",
			},
			{
				"<leader>zt",
				function()
					require("sidekick.cli").send({ msg = "{this}" })
				end,
				mode = { "x", "n" },
				desc = "Send This",
			},
			{
				"<leader>zf",
				function()
					require("sidekick.cli").send({ msg = "{file}" })
				end,
				desc = "Send File",
			},
			{
				"<leader>zv",
				function()
					require("sidekick.cli").send({ msg = "{selection}" })
				end,
				mode = { "x" },
				desc = "Send Visual Selection",
			},
			{
				"<leader>zp",
				function()
					require("sidekick.cli").prompt()
				end,
				mode = { "n", "x" },
				desc = "Sidekick Select Prompt",
			},
		},
		---@module "sidekick"
		---@type sidekick.Config
		opts = {
			-- add any options here
			cli = {
				mux = {
					backend = "zellij",
					enabled = true,
				},
				---@module "sidekick"
				---@type sidekick.win.Opts
				win = {
					---@type table<string, sidekick.cli.Keymap|false>
					keys = {
						show_keys = {
							"<F12>",
							function(term)
								vim.cmd.stopinsert()

								local keys = vim.tbl_extend("force", {}, term.opts.keys or {}, term.tool.keys or {})
								local lines = { "Sidekick keys:" }

								for name, km in pairs(keys) do
									if type(km) == "table" and km[1] then
										lines[#lines + 1] = string.format("%-10s %-12s %s", km[1], name, km.desc or "")
									end
								end

								vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, { title = "Sidekick" })
							end,
							mode = "nt",
							desc = "show Sidekick keymaps",
						},
					},
				},
			},
		},
	},
}
