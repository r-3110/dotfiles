# Amazon Q pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.pre.zsh"

# NOTE: 冒頭で設定すること
autoload bashcompinit && bashcompinit
autoload -U compinit && compinit

eval "$(starship init zsh)"

eval "$(sheldon source)"

# aws-cli completion
complete -C '/usr/local/bin/aws_completer' aws

source $HOME/dotfiles/.zsh_alias

zinit light zsh-users/zsh-autosuggestions

zinit light marlonrichert/zsh-autocomplete

# option + j で起動
zinit ice wait'!0'; zinit light reegnz/jq-zsh-plugin

zinit light mollifier/anyframe

zinit ice wait'!0'; zinit light paulirish/git-open

zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

zinit light Aloxaf/fzf-tab

# aws-cli completion
autoload bashcompinit && bashcompinit
complete -C '/usr/local/bin/aws_completer' aws

# Amazon Q post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/amazon-q/shell/zshrc.post.zsh"
