-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- ============================================================================
-- Configuration Builder
-- ============================================================================
local config = wezterm.config_builder()

-- ============================================================================
-- General Settings
-- ============================================================================
config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"

-- ============================================================================
-- Window & UI Settings
-- ============================================================================
config.window_decorations = "TITLE | RESIZE"
config.enable_tab_bar = true
config.tab_bar_at_bottom = false
config.use_fancy_tab_bar = true
config.tab_max_width = 32

-- ============================================================================
-- Font Configuration
-- ============================================================================
config.font = wezterm.font("Roboto Mono")
config.font_size = 12.5
config.line_height = 1.2
config.anti_alias_custom_block_glyphs = true

-- ============================================================================
-- Cursor Settings
-- ============================================================================
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 800

-- ============================================================================
-- Color Scheme
-- ============================================================================
config.color_scheme = "Gruvbox Dark"

-- ============================================================================
-- Shell Configuration
-- ============================================================================
config.default_prog = { "/usr/bin/zsh" }

-- ============================================================================
-- Scrollback Buffer
-- ============================================================================
config.scrollback_lines = 100000

-- ============================================================================
-- Performance Optimization
-- ============================================================================
config.enable_wayland = true

-- ============================================================================
-- Keybindings
-- ============================================================================
config.keys = {
	-- Split pane vertically (right)
	{
		key = "v",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane {
			direction = "Right",
			size = { Percent = 50 },
		},
	},
	-- Split pane horizontally (down)
	{
		key = "h",
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitPane {
			direction = "Down",
			size = { Percent = 50 },
		},
	},
	-- Close current pane
	{
		key = "w",
		mods = "CTRL|SHIFT",
		action = wezterm.action.CloseCurrentPane { confirm = false },
	},
	-- Navigate between panes
	{
		key = "LeftArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection "Left",
	},
	{
		key = "RightArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection "Right",
	},
	{
		key = "UpArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection "Up",
	},
	{
		key = "DownArrow",
		mods = "CTRL|SHIFT",
		action = wezterm.action.ActivatePaneDirection "Down",
	},
}

-- ============================================================================
-- Return Configuration
-- ============================================================================
return config
