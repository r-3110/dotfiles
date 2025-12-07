# Kiro CLI pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.pre.zsh"

DOTFILES_PATH="$HOME/dotfiles"

ZSH_PATH="$DOTFILES_PATH/.config/zsh"

source "$ZSH_PATH/.zsh_env"
source "$ZSH_PATH/.zsh_alias"

# NOTE: 冒頭で設定すること
autoload bashcompinit && bashcompinit
autoload -U compinit && compinit

eval "$(starship init zsh)"

eval "$(zoxide init zsh)"

eval "$(sheldon source)"

# aws-cli completion
complete -C '/usr/local/bin/aws_completer' aws

source "$ZSH_PATH/.zsh_functions"
# source $HOME/dotfiles/zeno.sh

# RooやClineのシェル統合用
[[ "$TERM_PROGRAM" == "vscode" ]] && . "$(code --locate-shell-integration-path zsh)"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/ryo/.docker/completions $fpath)
# End of Docker CLI completions

# Kiro CLI post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/kiro-cli/shell/zshrc.post.zsh"
