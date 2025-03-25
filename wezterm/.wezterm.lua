-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- Spawn a zsh shell in login mode
config.default_prog = { '/usr/bin/zsh' }

-- For example, changing the color scheme:
config.color_scheme = 'Batman'
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = true
config.scrollback_lines = 100000
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
-- Font
config.font = wezterm.font('MesloLGS Nerd Font Mono')
config.font_size = 12

config.enable_tab_bar = false

config.default_cursor_style = 'BlinkingBar'
config.window_decorations = 'RESIZE'

-- and finally, return the configuration to wezterm
return config
