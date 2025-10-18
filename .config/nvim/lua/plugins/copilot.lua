-- @see https://github.com/CopilotC-Nvim/CopilotChat.nvim

return {
	---@type LazyPluginSpec
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "canary",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		---@type CopilotChat.config
		opts = {
			-- copilotchatだとcodexが対応していない？
			-- model = "gpt-5-codex",
			model = "claude-sonnet-4.5",
			debug = false, -- Enable debugging
			show_help = true,
			-- See Configuration section for rest
			prompts = {
				Explain = {
					prompt = "/COPILOT_EXPLAIN コードを日本語で説明してください",
					mapping = "<leader>ce",
					description = "コードの説明をお願いする",
				},
				Review = {
					prompt = "/COPILOT_REVIEW コードを日本語でレビューしてください。",
					mapping = "<leader>cr",
					description = "コードのレビューをお願いする",
				},
				Fix = {
					prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードを表示してください。説明は日本語でお願いします。",
					mapping = "<leader>cf",
					description = "コードの修正をお願いする",
				},
				Optimize = {
					prompt = "/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。説明は日本語でお願いします。",
					mapping = "<leader>co",
					description = "コードの最適化をお願いする",
				},
				Docs = {
					prompt = "/COPILOT_GENERATE 選択したコードに関するドキュメントコメントを日本語で生成してください。",
					mapping = "<leader>cd",
					description = "コードのドキュメント作成をお願いする",
				},
				Tests = {
					prompt = "/COPILOT_TESTS 選択したコードの詳細なユニットテストを書いてください。説明は日本語でお願いします。",
					mapping = "<leader>ct",
					description = "テストコード作成をお願いする",
				},
				FixDiagnostic = {
					prompt = "コードの診断結果に従って問題を修正してください。修正内容の説明は日本語でお願いします。",
					mapping = "<leader>cd",
					description = "コードの修正をお願いする",
					---@param source CopilotChat.source
					selection = function(source)
						return require("CopilotChat.select").diagnostics(source)
					end,
				},
				Commit = {
					prompt = "実装差分に対するコミットメッセージを日本語で記述してください。",
					mapping = "<leader>cco",
					description = "コミットメッセージの作成をお願いする",
					selection = function()
						return require("CopilotChat.select").gitdiff()
					end,
				},
				CommitStaged = {
					prompt = "ステージ済みの変更に対するコミットメッセージを日本語で記述してください。",
					mapping = "<leader>cs",
					description = "ステージ済みのコミットメッセージの作成をお願いする",
					selection = function()
						return require("CopilotChat.select").gitdiff()
					end,
				},
			},
		},
	},
}
