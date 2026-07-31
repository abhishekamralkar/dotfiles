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

-- Glassy background with a soft blur behind the terminal text
config.window_background_opacity = 0.92
config.macos_window_background_blur = 20
config.text_background_opacity = 1.0

-- Breathing room around the terminal content
config.window_padding = {
	left = 14,
	right = 14,
	top = 10,
	bottom = 10,
}

-- Dim panes that aren't focused so the active one pops
config.inactive_pane_hsb = {
	saturation = 0.85,
	brightness = 0.6,
}

-- Smoother cursor/tab animations
config.animation_fps = 60
config.max_fps = 60

-- Match the titlebar to the theme instead of the OS default
config.window_frame = {
	font = wezterm.font("FiraCode Nerd Font Mono", { weight = "Bold" }),
	font_size = 12.0,
	active_titlebar_bg = "#11111b",
	inactive_titlebar_bg = "#11111b",
	active_titlebar_fg = "#cdd6f4",
	inactive_titlebar_fg = "#6c7086",
}

-- Fine-tune the fancy tab bar to match Catppuccin Mocha
config.colors = {
	tab_bar = {
		background = "#11111b",
		active_tab = {
			bg_color = "#45475a",
			fg_color = "#cdd6f4",
			intensity = "Bold",
		},
		inactive_tab = {
			bg_color = "#1e1e2e",
			fg_color = "#6c7086",
		},
		inactive_tab_hover = {
			bg_color = "#313244",
			fg_color = "#bac2de",
			italic = false,
		},
		new_tab = {
			bg_color = "#11111b",
			fg_color = "#6c7086",
		},
		new_tab_hover = {
			bg_color = "#313244",
			fg_color = "#f9e2af",
		},
	},
}

-- ============================================================================
-- Font Configuration
-- ============================================================================
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.font_size = 13.0
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
config.color_scheme = "Catppuccin Mocha"

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
-- Tab Titles
-- ============================================================================
wezterm.on("format-tab-title", function(tab)
	local title = tab.active_pane.title
	if tab.active_pane.foreground_process_name ~= "" then
		title = tab.active_pane.foreground_process_name:match("([^/\\]+)$") or title
	end
	local index = tab.tab_index + 1
	return string.format("  %d: %s  ", index, title)
end)

-- ============================================================================
-- Keybindings
-- ============================================================================
config.keys = {
	-- Split pane vertically (right)
	{
		key = "w",
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
		key = "x",
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
