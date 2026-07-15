local M = {}

---@class JjLocationCache
---@field cwd string
---@field updated_at integer
---@field value string
local cache = {
	cwd = "",
	updated_at = 0,
	value = "",
}

local cache_duration_ns = 1 * 1000 * 1000 * 1000
local current_template = 'bookmarks.map(|x| x.name()).join(",") ++ "|" ++ change_id.shortest(8)'
local base_template = 'bookmarks.map(|x| x.name()).join(",")'

---@return string
local function run_jj(revset, template)
	local result = vim.system({
		"jj",
		"--ignore-working-copy",
		"log",
		"--no-graph",
		"-r",
		revset,
		"-T",
		template,
	}, { text = true }):wait()

	if result.code ~= 0 then
		return ""
	end

	return vim.trim(result.stdout)
end

---@return string
local function read_location()
	local current = run_jj("@", current_template)
	if current == "" then
		return ""
	end

	local direct_bookmarks, change_id = current:match("^(.-)|(.+)$")
	if not direct_bookmarks or not change_id then
		return ""
	end

	local base_output = run_jj("heads(::parents(@) & bookmarks())", base_template)
	local bases = vim.tbl_filter(function(bookmark)
		return bookmark ~= ""
	end, vim.split(base_output, "\n", { plain = true }))
	local current_label = direct_bookmarks ~= "" and direct_bookmarks or change_id

	if #bases == 0 then
		return current_label
	end

	return current_label .. " ← " .. table.concat(bases, ", ")
end

---@return string
function M.location()
	local cwd = vim.fn.getcwd()
	local now = vim.uv.hrtime()

	if cache.cwd ~= cwd or now - cache.updated_at >= cache_duration_ns then
		cache = {
			cwd = cwd,
			updated_at = now,
			value = read_location(),
		}
	end

	if cache.value == "" then
		return ""
	end

	return "󰘬 jj: " .. cache.value
end

return M
