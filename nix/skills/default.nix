{
  lib,
  agent-skills,
  vercel-skills,
  github-awesome-copilot-skills,
  using-cmux,
  cmux-team,
  gh-stack,
  mizchi,
  difit,
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
      difit = {
        path = difit;
        subdir = "skills";
      };
      my-skills = {
        path = my-skills;
      };
    };
    skills.enable = [
      "find-skills"
      "conventional-commit"
      "create-github-pull-request-from-specification"
      "using-cmux"
      "cmux-team"
      "gh-stack"
      "empirical-prompt-tuning"
      "difit-review"
      "difit"
      "drawio"
      "draw-io-diagram-generator"
      "sql-optimization"
      "suggest-awesome-github-copilot-instructions"
      "suggest-awesome-github-copilot-skills"
      "suggest-awesome-github-copilot-agents"
      "git-lower-model"
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
