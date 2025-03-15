-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- Spawn a fish shell in login mode
config.default_prog = { '/usr/bin/zsh' }

-- For example, changing the color scheme:
config.color_scheme = 'Bamboo Light'

-- Font
config.font = wezterm.font 'JetBrains Mono'

-- and finally, return the configuration to wezterm
return config
