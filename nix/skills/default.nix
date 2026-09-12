{
  lib,
  agent-skills,
  archify,
  vercel-skills,
  semgrep-skills,
  chrome-devtools-mcp,
  github-awesome-copilot-skills,
  ayghri,
  gh-stack,
  mizchi,
  mattpocock,
  humanlayer,
  tuicr,
  herdr,
  hunk,
  my-skills,
  ...
}:
{
  imports = [
    (import "${agent-skills.outPath}/modules/home-manager/agent-skills.nix" {
      inherit lib;
      inputs = { };
    })
  ];

  programs.agent-skills = {
    enable = true;
    sources = {
      archify = {
        path = archify;
        subdir = "archify";
      };
      vercel = {
        path = vercel-skills;
        subdir = "skills";
      };
      semgrep = {
        path = semgrep-skills;
        subdir = "skills";
      };
      chrome-devtools = {
        path = chrome-devtools-mcp;
        subdir = "skills";
        idPrefix = "chromeDevtools";
      };
      github-awesome-copilot = {
        path = github-awesome-copilot-skills;
        subdir = "skills";
      };
      ayghri = {
        path = ayghri;
        subdir = "skills";
      };
      gh-stack = {
        path = gh-stack;
        subdir = "skills/gh-stack";
      };
      mizchi-meta = {
        path = mizchi;
        subdir = "meta";
      };
      mattpocock-productivity = {
        path = mattpocock;
        subdir = "skills/productivity";
      };
      humanlayer-show-me = {
        path = humanlayer;
        subdir = "plugins/show-me/skills";
      };
      tuicr = {
        path = tuicr;
        subdir = "skills";
      };
      herdr = {
        path = herdr;
        subdir = "skills";
      };
      hunk = {
        path = hunk;
        subdir = "packages/hunk/skills";
      };
      my-skills = {
        path = my-skills;
      };
    };
    skills.enable = [
      "archify"
      "find-skills"
      "code-security"
      "llm-security"
      "semgrep"
      "chromeDevtools/a11y-debugging"
      "chromeDevtools/chrome-devtools-cli"
      "chromeDevtools/chrome-devtools"
      "chromeDevtools/debug-optimize-lcp"
      "chromeDevtools/memory-leak-debugging"
      "chromeDevtools/troubleshooting"
      "conventional-commit"
      "conventional-commit-jj"
      "create-github-pull-request-from-specification"
      "i-have-adhd"
      "gh-stack"
      "empirical-prompt-tuning"
      "tuicr"
      "drawio"
      "draw-io-diagram-generator"
      "sql-optimization"
      "suggest-awesome-github-copilot-instructions"
      "suggest-awesome-github-copilot-skills"
      "suggest-awesome-github-copilot-agents"
      "git-lower-model"
      "create-readme"
      "grilling"
      "show-me"
      "herdr"
      "hunk-review"
      "herdr-jj-workflow"
      "using-jj-workspaces"
    ];
    targets = {
      # geminiとcodexは~/.agentsをサポート
      agents = {
        dest = "$HOME/.agents/skills";
        structure = "copy-tree";
      };
      # claudeとcopilotは~/.claudeをサポート
      claude = {
        dest = "$HOME/.claude/skills";
        structure = "copy-tree";
      };
      antigravity = {
        dest = "$HOME/.gemini/antigravity-cli/skills";
        structure = "copy-tree";
      };
    };
  };
}
