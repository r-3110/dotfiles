--@see https://github.com/mfussenegger/nvim-dap
--@see https://github.com/rcarriga/nvim-dap-ui
--@see https://codeberg.org/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript
--@see https://github.com/mxsdev/nvim-dap-vscode-js/issues/58#issuecomment-2582575821
--@see https://github.com/mfussenegger/nvim-dap/issues/1411#issuecomment-2566396879

return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		{
			"mfussenegger/nvim-dap",
			config = function()
				vim.notify("nvim-dap loaded")
			end,
		},
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
		{
			"microsoft/vscode-js-debug",
			build = "npm install --legacy-peer-deps && npx gulp dapDebugServer",
		},
	},
	lazy = true,
	config = function()
		local dapui = require("dapui")

		dapui.setup()

		local dap = require("dap")

		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = "node",
				-- 💀 Make sure to update this path to point to your installation
				args = { vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/dist/src/dapDebugServer.js", "${port}" },
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
	end,
}
