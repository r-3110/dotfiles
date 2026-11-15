# Herdr で OMC / OMX を使う

Home Manager で OMC と Herdr backend の環境変数を設定する。
OMX と Codex 本体は mise で管理する。OMX の skills・prompts・設定は Home Manager で個別配置せず、標準の `omx setup --scope user` で導入・管理する。

適用後、新しいログインシェルで Herdr のプロジェクトディレクトリを開く。

Claude Code は次で起動する。別の Herdr ワークスペースに Claude が開く。

```sh
omc --plugin-dir "$OMC_PLUGIN_ROOT"
```

Codex は次で起動する。現在のペインに Codex が開く。

```sh
omx
```

チーム開発・レビューは OMC / OMX の標準 skill に従う。
担当は Herdr の別タブに開く。同じタブの分割ペインにはならない。

OMX は Git リポジトリで担当用の worktree を作るため、チーム起動時にはクリーンな作業ツリーが必要。
