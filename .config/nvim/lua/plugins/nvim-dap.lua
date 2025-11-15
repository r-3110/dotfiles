--@see https://github.com/mfussenegger/nvim-dap
--@see https://github.com/rcarriga/nvim-dap-ui
--@see https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript
--@see https://github.com/mxsdev/nvim-dap-vscode-js/issues/58#issuecomment-2582575821
--@see https://github.com/mfussenegger/nvim-dap/issues/1411#issuecomment-2566396879
--@see https://github.com/jbyuki/one-small-step-for-vimkind

---@type LazyPluginSpec
return {
	"rcarriga/nvim-dap-ui",
	keys = {
		{
			"<Leader>du",
			function()
				---@module "dapui"
				require("dapui").toggle()
			end,
			desc = "Toggle DAP UI",
		},
		{
			"<Leader>db",
			function()
				---@module "dap"
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle DAP Breakpoint",
		},
	},
	dependencies = {
		{
			"mfussenegger/nvim-dap",
			dependencies = {
				{
					"mfussenegger/nvim-dap-python",
					ft = "python",
					config = function()
						---@module "dap-python"
						require("dap-python").setup("uv")
					end,
				},
				{ "jbyuki/one-small-step-for-vimkind" },
				{ "theHamsta/nvim-dap-virtual-text" },
			},
			-- なぜかconfigがないとsetupエラーになる
			config = function() end,
		},
		"nvim-neotest/nvim-nio",
	},

	config = function()
		---@module "dapui"
		local dapui = require("dapui")

		dapui.setup()

		---@module "dap"
		local dap = require("dap")

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				-- 💀 Make sure to update this path to point to your installation
				args = {
					vim.fn.expand("~/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"),
					"${port}",
				},
			},
		}

		dap.configurations.javascript = {
			{
				name = "Launch JavaScript Current File",
				type = "pwa-node",
				request = "launch",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
		}

		dap.configurations.typescript = {
			{
				name = "Launch TypeScript Using tsx Current File",
				type = "pwa-node",
				request = "launch",
				runtimeExecutable = "npx",
				runtimeArgs = { "tsx" },
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
		}

		dap.configurations.python = {
			{
				type = "debugpy",
				request = "launch",
				name = "Launch file",
				program = "${file}",
			},
		}

		dap.configurations.lua = {
			{
				type = "nlua",
				request = "attach",
				name = "Attach to running Neovim instance",
			},
		}

		dap.adapters.nlua = function(callback, config)
			callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 })
		end

		vim.keymap.set("n", "<leader>dl", function()
			---@module "osv"
			---@diagnostic disable-next-line: assign-type-mismatch
			require("osv").launch({ port = 8086 })
		end, { desc = "launch lua debugger in neovim", noremap = true })
	end,
}
