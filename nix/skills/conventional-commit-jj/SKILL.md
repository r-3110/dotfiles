---
name: conventional-commit-jj
description: Inspect the current Jujutsu change, generate a Conventional Commits description from its diff, and apply it with `jj describe`. Use when the user asks to describe, name, message, or conventionally commit the current jj change. Do not use it to squash, split, create, or publish changes.
---

# Conventional Commit for jj

Describe only the current working-copy change. Keep history-shaping and publishing operations outside this skill.

## Workflow

1. Run `pwd` and `jj log -r @ --no-graph` to verify the repository and current change before mutation.
2. Run `jj status` and `jj diff --summary` to identify the affected files.
3. Run `jj diff` and inspect the complete current-change diff. If the diff is too large, inspect every affected file in manageable sections.
4. Stop and explain the problem if the working-copy change is empty, the diff cannot be inspected, or the change contains unrelated intents that require splitting.
5. Construct a Conventional Commits description that represents the diff, not merely the user's wording.
6. Show the proposed description, then apply it to `@` with `jj describe -m '<description>'`.
7. Run `jj log -r @ --no-graph` and report the resulting description.

Do not run `jj squash`, `jj split`, `jj new`, bookmark commands, or push commands. Do not target a revision other than `@` unless the user explicitly requests it.

## Description format

Use this structure:

```text
<type>[(<scope>)][!]: <summary>

[optional body]

[optional footer]
```

Choose one of these types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, or `revert`.

- Use a concise, imperative, lowercase summary without a trailing period.
- Add a scope only when it makes the affected area clearer.
- Use a body when the motivation or important implementation detail is not clear from the summary.
- Mark a breaking change with `!` and add a `BREAKING CHANGE: <details>` footer.
- Preserve issue references in the footer when the diff or user supplies them; do not invent references.
- Describe the dominant coherent intent. If no single intent exists, recommend splitting instead of hiding multiple changes under a vague message.

## Examples

```text
feat(parser): support array expressions
fix(ui): align the submit button
docs: document jj workspace setup
refactor(auth)!: replace legacy session tokens

BREAKING CHANGE: existing session tokens are no longer accepted
```
