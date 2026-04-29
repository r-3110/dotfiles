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
      mizchi = {
        path = mizchi;
      };
      difit = {
        path = difit;
        subdir = "skills";
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
    ];
    skills.enableAll = [ "personal" ];
    targets = {
      # geminiは~/.agentsをサポート
      agents = {
        dest = ".agents/skills";
        structure = "copy-tree";
      };
      # claudeとcopilotは~/.claudeをサポート
      claude = {
        dest = ".claude/skills";
        structure = "copy-tree";
      };
    };
  };
}
