STARSHIP_CONFIG_DIR="$HOME/dotfiles/.config/starship"

STARSHIP_CONFIG_THEME="tokyo-night.toml"

export STARSHIP_CONFIG="$STARSHIP_CONFIG_DIR/$STARSHIP_CONFIG_THEME"

eval "$(starship init bash)"

eval "$(/usr/bin/mise activate)"

source $HOME/dotfiles/.zsh_alias
