--@see https://idursun.github.io/jjui/customization/lua-scripting/

-- luacheck: globals choose context exec_shell flash input jj revisions setup

---@alias CommitType
---| "feat"
---| "fix"
---| "docs"
---| "style"
---| "refactor"
---| "perf"
---| "test"
---| "build"
---| "ci"
---| "chore"
---| "revert"

---@class Choice<T>
---@field label string 画面に表示するラベル
---@field value T 選択時に返す値

---@class JjuiActionOptions
---@field key string キーバインド
---@field scope string アクションを有効にするスコープ
---@field desc string ヘルプに表示する説明

---@class JjuiSetupConfig
---@field action fun(name: string, callback: fun(), options: JjuiActionOptions) アクションを登録する

---@type Choice<CommitType>[]
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

---@type Choice<string>[]
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

--- 選択肢を表示し、選ばれたラベルに対応する値を返す。
---@generic T
---@param title string ダイアログのタイトル
---@param choices Choice<T>[] 表示する選択肢
---@return T? value 選択がキャンセルされた場合はnil
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

--- Conventional Commits形式の1行メッセージを生成する。
---@param commit_type CommitType 変更種別
---@param scope string 省略可能な変更スコープ
---@param description string 命令形の変更概要
---@param breaking boolean 破壊的変更を示すか
---@return string message 生成したメッセージ
local function build_commit_message(commit_type, scope, description, breaking)
	local scope_part = scope ~= "" and "(" .. scope .. ")" or ""
	local breaking_part = breaking and "!" or ""

	return commit_type .. scope_part .. breaking_part .. ": " .. description
end

--- シェル引数として安全に渡せるよう、文字列をシングルクォートする。
---@param value string クォートする文字列
---@return string quoted クォート済み文字列
local function shell_quote(value)
	return "'" .. value:gsub("'", "'\\''") .. "'"
end

--- jjuiの詳細ビューで選択中のファイルをエディタで開く。
local function edit_selected_file()
	local file = context.file()
	if not file then
		flash({ text = "ファイルが選択されていません", error = true })
		return
	end

	exec_shell("${EDITOR:-vi} " .. shell_quote(file))
end

--- Conventional Commits形式のメッセージを対話的に組み立てる。
---@return string? message 入力がキャンセルされた場合はnil
local function prompt_conventional_message()
	local commit_type = select_value("変更の種類", commit_types)
	if not commit_type then
		return nil
	end

	local scope = select_value("変更のスコープ（任意）", scopes)
	if scope == nil then
		return nil
	end

	local description = input({
		title = "変更内容",
		prompt = "命令形・短めに入力してください",
	})
	if not description then
		return nil
	end

	description = description:match("^%s*(.-)%s*$")
	if description == "" then
		flash({ text = "変更内容を入力してください", error = true })
		return nil
	end

	local breaking = select_value("破壊的変更を含みますか？", {
		{ label = "No", value = false },
		{ label = "Yes", value = true },
	})
	if breaking == nil then
		return nil
	end

	return build_commit_message(commit_type, scope, description, breaking)
end

--- 生成したメッセージを表示し、指定した操作を実行するか確認する。
---@param action string 確認ダイアログに表示する操作名
---@param message string Conventional Commits形式のメッセージ
---@return boolean confirmed 操作が選択された場合はtrue
local function confirm_message(action, message)
	local confirmation = choose({
		options = { action, "Cancel" },
		title = message,
		ordered = true,
	})

	return confirmation == action
end

--- 作業コピーをConventional Commits形式でdescribeし、新しい変更を作成する。
local function conventional_commit()
	local message = prompt_conventional_message()
	if not message or not confirm_message("Commit", message) then
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

--- 選択中の変更へConventional Commits形式のdescriptionを設定する。
local function conventional_describe()
	local change_id = context.change_id()
	if not change_id then
		flash({ text = "変更が選択されていません", error = true })
		return
	end

	local message = prompt_conventional_message()
	if not message or not confirm_message("Describe", message) then
		return
	end

	local _, err = jj("describe", "-r", change_id, "-m", message)
	if err then
		flash({ text = err, error = true, sticky = true })
		return
	end

	revisions.refresh({ keep_selections = true, selected_revision = change_id })
	flash("Described: " .. message)
end

--- jjui起動時にカスタムアクションとキーバインドを登録する。
---@param config JjuiSetupConfig jjuiから渡されるセットアップ設定
---@diagnostic disable-next-line: lowercase-global -- jjuiが呼び出すグローバルエントリポイント
function setup(config)
	config.action("conventional-commit", conventional_commit, {
		key = "C",
		scope = "revisions",
		desc = "conventional commit",
	})

	config.action("conventional-describe", conventional_describe, {
		key = "alt+c",
		scope = "revisions",
		desc = "conventional describe",
	})

	config.action("edit-selected-file", edit_selected_file, {
		key = "e",
		scope = "revisions.details",
		desc = "edit file",
	})
end
