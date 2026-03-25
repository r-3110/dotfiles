{
  lib,
  agent-skills,
  vercel-skills,
  github-awesome-copilot-skills,
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
    };
    skills.enable = [
      "find-skills"
      "conventional-commit"
      "create-github-pull-request-from-specification"
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
