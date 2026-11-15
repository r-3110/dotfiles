{ agentPackages }:
let
  omc = agentPackages.oh-my-claudecode;
  omcRoot = "${omc}/lib/node_modules/oh-my-claude-sisyphus";
in
{
  home.packages = [
    omc
  ];

  home.sessionVariables = {
    OMC_PLUGIN_ROOT = omcRoot;
    OMC_TEAM_MULTIPLEXER = "herdr";
    OMX_MULTIPLEXER = "herdr";
    # The interactive Codex lead stays in the calling Herdr pane.
    OMX_LAUNCH_POLICY = "direct";
    OMX_TEAM_WORKER_CLI = "codex";
  };

}
