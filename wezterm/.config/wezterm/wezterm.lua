-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config = {
	automatically_reload_config = true,
	enable_tab_bar = true,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	default_cursor_style = "BlinkingBar",
	color_scheme = "Nord (Gogh)",
	font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
	font_size = 12.5,
	default_prog = { "/usr/bin/zsh" },

}

-- and finally, return the configuration to wezterm
return config
