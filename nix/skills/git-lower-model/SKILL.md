---
name: git-lower-model
description: Delegate git and GitHub CLI operations to the current tool's cheaper, smaller, or lower-tier model. Use when an agent needs to run, inspect, or summarize git commands such as status, diff, log, branch, add, commit, fetch, pull, push, rebase, merge, stash, tag, worktree, or branch preparation, or GitHub CLI commands such as gh pr view, gh pr diff, gh pr status, gh run list, gh run view, gh pr create, or gh pr edit, while keeping non-repository code editing and reasoning in the current agent.
---

# Git Lower Model

## Overview

Use a lower-model subagent for git and GitHub CLI operations only. Keep code changes, test analysis, product decisions, and final user communication in the parent agent unless the user explicitly asks otherwise.

## Boundary

Treat these as repository operations:

- Repository inspection: `git status`, `git diff`, `git log`, `git show`, `git branch`, `git remote`, `git worktree`, `git blame`.
- Repository state changes: `git add`, `git commit`, `git stash`, `git checkout`, `git switch`, `git branch`, `git merge`, `git rebase`, `git tag`.
- Remote synchronization: `git fetch`, `git pull`, `git push`.
- Git-adjacent handoff checks: branch name selection, commit range inspection, and concise git output summaries.
- GitHub CLI read-only inspection: `gh pr view`, `gh pr diff`, `gh pr status`, `gh pr checks`, `gh run list`, `gh run view`, `gh issue view`, `gh repo view`.
- GitHub CLI state changes: `gh pr create`, `gh pr edit`, `gh pr comment`, `gh pr ready`, `gh pr close`, `gh workflow run`, `gh run rerun`, `gh issue comment`, `gh issue edit`.

Do not delegate non-repository work through this skill:

- Reading or editing product files, tests, docs, or config outside what a `git` or `gh` command outputs.
- Deciding implementation strategy.
- Running non-git build, lint, test, package-manager, database, or deployment commands.
- Using direct GitHub APIs or MCP connectors unless another active skill or the user explicitly asks for that workflow.

## Model Selection

Select the lower model by runtime instead of hard-coding one provider's model name:

- Codex/OpenAI: use the currently available small, mini, or cost-efficient coding model. Prefer the model advertised by the tool as the small/fast option over a stale literal model name.
- Claude Code/Anthropic: use the current Haiku-family model for repository delegation.
- Other agents: use the lowest-cost model that can run shell/git commands reliably.

If the user explicitly names a lower model, use that model. If the runtime exposes no model override or no subagent support, run the git command locally with the same safety constraints.

## Delegation Workflow

When a repository operation is needed and subagents are available, spawn exactly one bounded subagent using the lower model selected above. Use the lowest practical reasoning or thinking setting for routine inspection; raise it only for conflict-heavy rebases, tricky commit splitting, PR creation, or other repository tasks where mistakes are likely.

Use a read-only/default role for read-only work and a worker/executor role for state-changing work when the runtime distinguishes roles. Set context sharing to minimal or off unless the subagent needs conversation context to choose files, commit wording, or PR wording.

Prompt the subagent with:

```text
Use only git or GitHub CLI (`gh`) commands for this task. Do not edit files directly. Do not run build, test, package-manager, database, deployment, or network commands other than git or gh operations explicitly needed for the task. Report the exact commands run, the important output, and any risk or user approval needed.

Task: <specific repository operation>
Repository: <absolute repository path>
Constraints: <approval, destructive-command, or staging constraints>
```

Wait for the subagent only when the repository result is needed for the next step. Integrate the reported `git` or `gh` output into the parent agent's next action or final response.

## Safety Rules

Check the parent instructions before delegating. If tool policy or the current environment does not permit subagent use, model override, or shell access, run the git command locally with the same safety constraints and mention that delegation was unavailable only if relevant.

Never delegate or run destructive repository commands without explicit user approval, including `git reset --hard`, `git clean`, deleting branches with unmerged work, force-pushes, checkout/reset operations that discard uncommitted changes, `gh pr merge`, `gh release delete`, or any command that closes, merges, deletes, publishes, or reruns production-impacting GitHub state.

Before commits, require a clean understanding of the intended scope:

- Inspect `git status --short`.
- Stage only files that belong to the user's requested change.
- Preserve unrelated user changes.
- Use the user's requested commit message when provided.

Before pushes, inspect the branch and upstream state. Ask before force-pushing unless the user already explicitly requested it.

Before GitHub CLI state changes, inspect the target owner, repository, PR, issue, run, or workflow. Ask before merging, closing, commenting publicly, editing PR metadata, triggering workflows, rerunning workflows, or creating releases unless the user already explicitly requested that exact action.

## Response Handling

Summarize git results concisely in the parent response. Include command outcomes that change repository state, current branch, commit hash when created, and any unresolved risk.
