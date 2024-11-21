autoload -Uz compinit
compinit

eval "$(starship init zsh)"

source $HOMEBREW_PREFIX/opt/zinit/zinit.zsh

# plugins
# https://github.com/unixorn/awesome-zsh-plugins?tab=readme-ov-file#plugins
zinit light zdharma/fast-syntax-highlighting

zinit load zdharma/history-search-multi-word

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

source $HOME/dotfiles/.zsh_alias
