-- @see https://github.com/monaqa/dial.nvim

return {
	"monaqa/dial.nvim",
	config = function()
		local augend = require("dial.augend")
		require("dial.config").augends:register_group({
			default = {
				augend.date.alias["%d/%m/%Y"],
				augend.date.alias["%m/%d/%y"],
				augend.date.alias["%d/%m/%y"],
				augend.date.alias["%m/%d"],
				augend.date.alias["%-m/%-d"],
				augend.date.alias["%Y-%m-%d"],
				augend.date.alias["%d.%m.%Y"],
				augend.date.alias["%d.%m.%y"],
				augend.date.alias["%d.%m."],
				augend.date.alias["%-d.%-m."],
				augend.date.alias["%Y年%-m月%-d日"],
				augend.date.alias["%Y年%-m月%-d日(%ja)"],
				augend.date.alias["%H:%M:%S"],
				augend.date.alias["%H:%M"],
				augend.constant.alias.ja_weekday,
				augend.constant.alias.ja_weekday_full,
				augend.constant.alias.bool,
				augend.case.new({
					types = { "PascalCase", "camelCase", "snake_case", "kebab-case" },
					cyclic = true,
				})
			},
		})
	end,
}
