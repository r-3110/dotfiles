{
  description = "Agent Skills";

  inputs = {
    agent-skills.url = "github:Kyure-A/agent-skills-nix";
    vercel-skills = {
      url = "github:vercel-labs/skills";
      flake = false;
    };
    github-awesome-copilot-skills = {
      url = "github:github/awesome-copilot";
      flake = false;
    };
    using-cmux = {
      url = "github:hummer98/using-cmux";
      flake = false;
    };
    cmux-team = {
      url = "github:hummer98/cmux-team";
      flake = false;
    };
    gh-stack = {
      url = "github:github/gh-stack";
      flake = false;
    };
    mizchi = {
      url = "github:mizchi/skills";
      flake = false;
    };
  };

  outputs =
    inputs@{ self, ... }:
    {
      homeManagerModules.default =
        { ... }@args:
        import ./default.nix (
          args
          // {
            inherit (inputs)
              agent-skills
              vercel-skills
              github-awesome-copilot-skills
              using-cmux
              cmux-team
              gh-stack
              mizchi
              ;
          }
        );
    };
}
