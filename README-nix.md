# Nix Development Environment

mise設定をNixで再現した開発環境設定です。

## 使い方

### 方法1: nix develop (推奨)

Flakesを使用した最新の方法:

```bash
# 開発環境に入る
nix develop

# または、direnvと組み合わせる
echo "use flake" > .envrc
direnv allow
```

### 方法2: Home Manager統合

Home Managerを使用している場合:

```nix
# ~/.config/home-manager/flake.nix に追加
{
  inputs = {
    dotfiles.url = "path:/home/ryo/dotfiles";
  };

  outputs = { self, nixpkgs, home-manager, dotfiles, ... }: {
    homeConfigurations."your-username" = home-manager.lib.homeManagerConfiguration {
      modules = [
        dotfiles.homeManagerModules.default
        # ... other modules
      ];
    };
  };
}
```

## 含まれるツール

### プログラミング言語
- **bun**: JavaScript/TypeScript runtime
- **deno**: Secure TypeScript runtime
- **go**: Go language (1.25.5)
- **java**: Java Development Kit (25.0.1)
- **lua**: Lua 5.4.7
- **node**: Node.js 22.15.0
- **python**: Python 3.13.5
- **ruby**: Ruby 4.0
- **rust**: Rust toolchain (1.88.0)

### 開発ツール
- **bat**: cat clone with syntax highlighting
- **delta**: Git diff viewer
- **eza**: Modern ls replacement
- **fd**: Find alternative
- **fzf**: Fuzzy finder
- **ghq**: Repository management
- **jq/yq**: JSON/YAML processors
- **lazygit**: Terminal Git UI
- **lazydocker**: Docker terminal UI
- **neovim**: Vim-based editor (0.11.5)
- **ripgrep**: Fast grep alternative
- **tmux**: Terminal multiplexer
- **yazi**: Terminal file manager
- **zellij**: Terminal workspace

### GitHub/Git
- **gh**: GitHub CLI
- **git-open**: Open repo in browser
- **gitui**: Terminal Git UI
- **jujutsu (jj)**: Version control system

### クラウド/インフラ
- **aws-cli**: AWS CLI v2
- **aws-sso**: AWS SSO CLI
- **cloudflared**: Cloudflare tunnel
- **ecspresso**: ECS deployment tool
- **gcloud**: Google Cloud SDK
- **pulumi**: Infrastructure as Code

### その他
- **act**: Run GitHub Actions locally
- **ov**: Feature-rich pager
- **sheldon**: Fast Zsh plugin manager
- **starship**: Shell prompt
- **uv**: Python package manager
- **zoxide**: Smarter cd command

## Zsh プラグイン

Sheldonで管理されているプラグイン:
- zsh-defer: Deferred loading
- fast-syntax-highlighting: Syntax highlighting
- history-search-multi-word: History search (Ctrl+R)
- zeno.zsh: Snippet completion
- zsh-autosuggestions: Command suggestions
- jq-zsh-plugin: JQ integration (Option+J)
- git-open: Git repository opener
- gh-fzf: GitHub CLI + FZF
- cd-gitroot: Jump to git root
- fzf-tab: FZF tab completion
- zsh-vi-mode: Vi mode for Zsh
- zsh-vi-man: Vi-style man pages
- by-binds-yourself: Custom keybindings

## NPM グローバルパッケージ

以下のNPMパッケージはnpxまたは別途インストールが必要:
- `@anthropic-ai/claude-code`: Claude Code CLI
- `@github/copilot`: GitHub Copilot CLI
- `@google/gemini-cli`: Gemini CLI
- `editprompt`: Prompt editor
- `mdjanai`: Markdown AI tool
- `zenn-cli`: Zenn publishing

インストール方法:
```bash
npm install -g @anthropic-ai/claude-code @github/copilot zenn-cli editprompt
```

または、uvx/pipxで:
```bash
# Python tools
pipx install posting  # darrenburns/posting
```

## mise vs Nix の違い

### miseの利点
- 簡単なバージョン切り替え
- プロジェクトごとの設定 (.tool-versions)
- npm/aqua/pipxパッケージの直接管理

### Nixの利点
- 完全な再現性
- OSレベルでの分離
- 宣言的な設定
- ビルドキャッシュ

## トラブルシューティング

### Flakesが有効でない場合

```bash
# ~/.config/nix/nix.conf に追加
experimental-features = nix-command flakes
```

### パッケージが見つからない場合

```bash
# パッケージを検索
nix search nixpkgs <package-name>
```

### NPMグローバルパッケージ

Nixの分離環境ではNPMグローバルパッケージは含まれていません。
プロジェクトごとに`package.json`で管理するか、上記のコマンドで個別にインストールしてください。

## 更新

```bash
# Flakeの依存関係を更新
nix flake update

# 開発環境を再構築
nix develop --refresh
```
