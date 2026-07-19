--@see https://idursun.github.io/jjui/customization/lua-scripting/

-- luacheck: globals choose context exec_shell flash input jj revisions setup

local commit_types = {
	{ label = "Feature", value = "feat" },
	{ label = "Fix", value = "fix" },
	{ label = "Documentation", value = "docs" },
	{ label = "Styles", value = "style" },
	{ label = "Code Refactoring", value = "refactor" },
	{ label = "Performance Improvements", value = "perf" },
	{ label = "Tests", value = "test" },
	{ label = "Builds", value = "build" },
	{ label = "Continuous Integration", value = "ci" },
	{ label = "Chores", value = "chore" },
	{ label = "Reverts", value = "revert" },
}

local scopes = {
	{ label = "None", value = "" },
	{ label = "app", value = "app" },
	{ label = "ui", value = "ui" },
	{ label = "front", value = "front" },
	{ label = "back", value = "back" },
	{ label = "infra", value = "infra" },
	{ label = "api", value = "api" },
	{ label = "auth", value = "auth" },
	{ label = "data", value = "data" },
	{ label = "state", value = "state" },
	{ label = "config", value = "config" },
	{ label = "deps", value = "deps" },
	{ label = "build", value = "build" },
	{ label = "ci", value = "ci" },
	{ label = "docs", value = "docs" },
	{ label = "test", value = "test" },
}

local function select_value(title, choices)
	local labels = {}
	local values = {}

	for _, choice in ipairs(choices) do
		table.insert(labels, choice.label)
		values[choice.label] = choice.value
	end

	local selected = choose({
		options = labels,
		title = title,
		ordered = true,
	})

	if not selected then
		return nil
	end

	return values[selected]
end

local function build_commit_message(commit_type, scope, description, breaking)
	local scope_part = scope ~= "" and "(" .. scope .. ")" or ""
	local breaking_part = breaking and "!" or ""

	return commit_type .. scope_part .. breaking_part .. ": " .. description
end

local function shell_quote(value)
	return "'" .. value:gsub("'", "'\\''") .. "'"
end

local function edit_selected_file()
	local file = context.file()
	if not file then
		flash({ text = "ファイルが選択されていません", error = true })
		return
	end

	exec_shell("${EDITOR:-vi} " .. shell_quote(file))
end

local function conventional_commit()
	local commit_type = select_value("コミットする変更の種類", commit_types)
	if not commit_type then
		return
	end

	local scope = select_value("変更のスコープ（任意）", scopes)
	if scope == nil then
		return
	end

	local description = input({
		title = "変更内容",
		prompt = "命令形・短めに入力してください",
	})
	if not description then
		return
	end

	description = description:match("^%s*(.-)%s*$")
	if description == "" then
		flash({ text = "変更内容を入力してください", error = true })
		return
	end

	local breaking = select_value("破壊的変更を含みますか？", {
		{ label = "No", value = false },
		{ label = "Yes", value = true },
	})
	if breaking == nil then
		return
	end

	local message = build_commit_message(commit_type, scope, description, breaking)
	local confirmation = choose({
		options = { "Commit", "Cancel" },
		title = message,
		ordered = true,
	})
	if confirmation ~= "Commit" then
		return
	end

	local _, err = jj("commit", "-m", message)
	if err then
		flash({ text = err, error = true, sticky = true })
		return
	end

	revisions.refresh({ keep_selections = true })
	flash("Committed: " .. message)
end

function setup(config)
	config.action("conventional-commit", conventional_commit, {
		key = "C",
		scope = "revisions",
		desc = "conventional commit",
	})

	config.action("edit-selected-file", edit_selected_file, {
		key = "e",
		scope = "revisions.details",
		desc = "edit file",
	})
end
