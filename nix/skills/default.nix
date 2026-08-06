{
  lib,
  agent-skills,
  vercel-skills,
  semgrep-skills,
  chrome-devtools-mcp,
  github-awesome-copilot-skills,
  using-cmux,
  cmux-team,
  gh-stack,
  mizchi,
  mattpocock,
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
      using-cmux = {
        path = using-cmux;
        subdir = "skills/using-cmux";
      };
      cmux-team = {
        path = cmux-team;
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
        subdir = "skills";
      };
      my-skills = {
        path = my-skills;
      };
    };
    skills.enable = [
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
      "using-cmux"
      "cmux-team"
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
      "herdr"
      "hunk-review"
      "herdr-jj-workflow"
      "using-jj-workspaces"
    ];
    skills.enableAll = [ "personal" ];
    targets = {
      # geminiとcodexは~/.agentsをサポート
      agents = {
        dest = ".agents/skills";
        structure = "copy-tree";
      };
      # claudeとcopilotは~/.claudeをサポート
      claude = {
        dest = ".claude/skills";
        structure = "copy-tree";
      };
      antigravity = {
        dest = ".gemini/antigravity-cli/skills";
        structure = "copy-tree";
      };
    };
  };
}
