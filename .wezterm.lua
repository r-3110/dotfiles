-- @see https://wezfurlong.org/wezterm/config/files.html
-- @see https://wezfurlong.org/wezterm/config/lua/general.html

-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'iceberg-dark'

config.initial_rows = 35
config.initial_cols = 120
config.font_size = 18.0
config.font = wezterm.font_with_fallback { "MesloLGS NF" }

-- and finally, return the configuration to wezterm
return config