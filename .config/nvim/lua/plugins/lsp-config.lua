-- @see https://github.com/nvimtools/none-ls.nvim
-- @see https://github.com/jose-elias-alvarez/null-ls.nvim
-- @see https://github.com/williamboman/mason.nvim

-- テーブルをダンプする関数
-- @param t ダンプ対象のテーブル
-- @param indent インデントレベル（再帰呼び出し用）
local function dumpTable(t, indent)
	indent = indent or 0
	local prefix = string.rep("  ", indent) -- インデント用のスペース
	if type(t) ~= "table" then
		return tostring(t) -- テーブル以外はそのまま返す
	end

	local result = "{\n"
	for key, value in pairs(t) do
		-- キーを文字列に変換
		local keyStr = tostring(key)
		if type(key) == "string" then
			keyStr = string.format("%q", key) -- 文字列キーを引用符で囲む
		end

		-- 値を適切にダンプ
		local valueStr
		if type(value) == "table" then
			valueStr = dumpTable(value, indent + 1) -- 再帰呼び出し
		else
			valueStr = tostring(value)
			if type(value) == "string" then
				valueStr = string.format("%q", value) -- 文字列値を引用符で囲む
			end
		end

		result = result .. prefix .. "  [" .. keyStr .. "] = " .. valueStr .. ",\n"
	end
	result = result .. prefix .. "}"
	return result
end

return {
	-- {
	-- 	"mfussenegger/nvim-lint",
	-- 	events = { "BufWritePost", "BufReadPost", "InsertLeave" },
	-- 	config = function()
	-- 		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
	-- 			callback = function()
	-- 				require("lint").try_lint()
	-- 			end,
	-- 		})
	-- 	end,
	-- 	opts = {
	-- 		-- Event to trigger linters
	-- 		events = { "BufWritePost", "BufReadPost", "InsertLeave" },
	-- 		linters_by_ft = {
	-- 			fish = { "fish" },
	-- 			zsh = { "zsh" },
	-- 			cfn_lint = { "cfn-lint" },
	-- 			markdown = { "vale" },
	-- 			yaml = { "yamllint" },
	-- 			["yaml.ghaction"] = { "actionlint" },

	-- 			-- Use the "*" filetype to run linters on all filetypes.
	-- 			-- ['*'] = { 'global linter' },
	-- 			-- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
	-- 			-- ['_'] = { 'fallback linter' },
	-- 			-- ["*"] = { "typos" },
	-- 		},
	-- 		-- LazyVim extension to easily override linter options
	-- 		-- or add custom linters.
	-- 		---@type table<string,table>
	-- 		linters = {
	-- 			-- -- Example of using selene only when a selene.toml file is present
	-- 			-- selene = {
	-- 			--   -- `condition` is another LazyVim extension that allows you to
	-- 			--   -- dynamically enable/disable linters based on the context.
	-- 			--   condition = function(ctx)
	-- 			--     return vim.fs.find({ "selene.toml" }, { path = ctx.filename, upward = true })[1]
	-- 			--   end,
	-- 			-- },
	-- 		},
	-- 	},
	-- },
	{
		"nvimtools/none-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = function(_, opts)
			local nls = require("null-ls")

			nls.setup({
				debug = false,
				sources = {
					nls.builtins.formatting.fish_indent,
					nls.builtins.diagnostics.fish,
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.shfmt,
					nls.builtins.diagnostics.cfn_lint.with({
						-- @see https://github.com/nvimtools/none-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md
						args = { "--format", "parseable", "$FILENAME" },
					}),
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				yamlls = {
					filetypes = { "yaml", "yml" },
					settings = {
						yaml = {
							customTags = {
								"!And",
								"!And sequence",
								"!If",
								"!If sequence",
								"!Not",
								"!Not sequence",
								"!Equals",
								"!Equals sequence",
								"!Or",
								"!Or sequence",
								"!FindInMap",
								"!FindInMap sequence",
								"!Base64",
								"!Join",
								"!Join sequence",
								"!Cidr",
								"!Ref",
								"!Sub",
								"!Sub sequence",
								"!GetAtt",
								"!GetAZs",
								"!ImportValue",
								"!ImportValue sequence",
								"!Select",
								"!Select sequence",
								"!Split",
								"!Split sequence",
							},
						},
					},
				},
			},
		},
	},
	-- add any tools you want to have installed below
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"stylua",
				"shellcheck",
				"shfmt",
				"flake8",
				"hadolint",
				"phpcs",
				"php-cs-fixer",
			},
		},
	},
}
