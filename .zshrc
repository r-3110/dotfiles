# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source $HOMEBREW_PREFIX/opt/zinit/zinit.zsh 

zinit ice depth=1; zinit light romkatv/powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
typeset -g POWERLEVEL9K_INSTANT_PROMPT=off

# plugins
zinit light zdharma/fast-syntax-highlighting

zinit load zdharma/history-search-multi-word

zinit light zsh-users/zsh-autosuggestions

zinit light marlonrichert/zsh-autocomplete

zinit light reegnz/jq-zsh-plugin

zinit light mollifier/anyframe

zinit light paulirish/git-open

zinit light Aloxaf/fzf-tab

zinit ice as"program" from"gh-r" mv"bat* -> bat" pick"bat/bat"
zinit light sharkdp/bat

# autoload bashcompinit && bashcompinit
# source ~/.zinit/plugins/drgr33n---oh-my-zsh_aws2-plugin/aws2_zsh_completer.sh
# complete -C '/usr/local/bin/aws_completer' aws
# zinit light drgr33n/oh-my-zsh_aws2-plugin

# my alias
source $HOME/dotfiles/.zsh_alias