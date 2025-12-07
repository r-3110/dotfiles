import { defineConfig } from "@yuki-yano/zeno";

// deno-lint-ignore no-unused-vars
export default defineConfig(({ projectRoot, currentDirectory }) => ({
  snippets: [
    {
      name: "open file with nvim",
      keyword: "NV",
      snippet: 'nvim "$(fzf)"',
    },
    {
      name: "paste open with nvim on mac",
      keyword: "NP",
      snippet: "pbpaste | nvim -",
    },
    {
      name: "paste open with nvim on WSL",
      keyword: "NPW",
      snippet:
        'powershell.exe -NoProfile -Command "[Console]::OutputEncoding=[System.Text.Encoding]::UTF8; Get-Clipboard" | nvim -',
    },
    {
      name: "rg + fzf + bat preview",
      keyword: "RFB",
      snippet:
        "rg --line-number --no-heading --color=always '' | fzf --ansi --delimiter : --preview 'bat --style=numbers --color=always {1} --highlight-line {2}' --bind 'enter:execute(nvim {1} +{2})'",
    },
    {
      name: "docker compose",
      keyword: "DC",
      snippet: "docker compose",
    },
    {
      name: "git status",
      keyword: "gs",
      snippet: "git status --short --branch",
    },
    {
      name: "git log",
      keyword: "gl",
      snippet: "git log --oneline --graph --decorate",
    },
    {
      name: "ghq cd",
      keyword: "ghql",
      snippet: 'cd "$(ghq list --full-path | fzf)"',
    },
    {
      name: "cd gitroot",
      keyword: "cdg",
      snippet: "cd-gitroot",
    },
    {
      name: "lazygit",
      keyword: "lg",
      snippet: "lazygit",
    },
    {
      name: "branch",
      keyword: "B",
      snippet: "git symbolic-ref --short HEAD",
      context: { lbuffer: "^git\\s+checkout\\s+" },
      evaluate: true,
    },
    {
      name: "cd there",
      keyword: "CD",
      snippet: "&& cd $_",
      context: { lbuffer: ".+\\s" },
    },
    {
      name: "copy by mac",
      keyword: "CC",
      snippet: "| pbcopy",
      context: { lbuffer: ".+\\s" },
    },
    {
      name: "grep",
      keyword: "G",
      snippet: "| grep",
      context: { lbuffer: ".+\\s" },
    },
    {
      name: "fzf",
      keyword: "F",
      snippet: "| fzf",
      context: { lbuffer: ".+\\s" },
    },
    {
      name: "null",
      keyword: "null",
      snippet: ">/dev/null 2>&1",
      context: { lbuffer: ".+\\s" },
    },
    {
      name: "ov-exec",
      keyword: "OVE",
      snippet: "ov --follow-all --exec --",
    },
  ],
  completions: [
    {
      name: "aws cli completer",
      patterns: ["^\\s*aws(?:$|\\s.*)$"],
      sourceCommand:
        'COMP_LINE="${LBUFFER}${RBUFFER}" COMP_POINT=${#LBUFFER} /usr/local/bin/aws_completer 2>/dev/null',
      options: {
        "--prompt": "'aws > '",
      },
    },
  ],
}));
