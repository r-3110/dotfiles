STARSHIP_CONFIG_DIR="$HOME/dotfiles/.config/starship"

STARSHIP_CONFIG_THEME="tokyo-night.toml"

export STARSHIP_CONFIG="$STARSHIP_CONFIG_DIR/$STARSHIP_CONFIG_THEME"

eval "$(starship init bash)"

export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
