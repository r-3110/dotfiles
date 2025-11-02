import { defineConfig } from "@yuki-yano/zeno";

export default defineConfig(({ projectRoot, currentDirectory }) => ({
  snippets: [
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
      name: "cd gitroot",
      keyword: "cdg",
      snippet: "cd-gitroot",
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
      name: "null",
      keyword: "null",
      snippet: ">/dev/null 2>&1",
      context: { lbuffer: ".+\\s" },
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
