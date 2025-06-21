--@see https://github.com/ActivityWatch/aw-watcher-vim- 2025-04-09T20:24:03

local enabled
if vim.fn.has("mac") == 1 then
	enabled = true
elseif vim.fn.has("linux") == 1 or vim.fn.has("wsl") == 1 then
	enabled = false
end

---@type LazyPluginSpec
return {
	enabled = enabled,
	"ActivityWatch/aw-watcher-vim",
}
