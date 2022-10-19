local wezterm = require "wezterm"

color = {
	foreground = "#657b83",
	emphasizedForeground = "#586e75",
	inverseEmphasizedBackground = "#073642",
	inverseBackground = "#002b36",
	inverseForeground = "#839496",
	deemphasizedForeground = "#93a1a1",
	emphasizedBackground = "#eee8d5",
	background = "#fdf6e3",
	hyper = "#268bd2",
	super = "#2aa198",
	accent = "#859900",
	minor = "#d33682",
	attention = "#cb4b16",
	alert = "#dc322f",
	major = "#6c71c4",
	inverseAccent = "#b58900",
}

-- Run a shell command and capture its stdout.
-- See: https://stackoverflow.com/a/326715
function os.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

-- Tune the font size for each host.
--
-- For vm-lamu, I double the default font size (12) due to DPI-related scaling
-- issues.
function get_font_size_by_host()
	local host = os.capture("hostname", false)
	if host == "berrio" then return 16
	elseif host == "vm-lamu" then return 24
	else return 12
	end
end

return {
	window_decorations = "NONE",
	enable_tab_bar = false,
	font = wezterm.font("Fira Code"),
	bold_brightens_ansi_colors = false,

	font_size = get_font_size_by_host(),

	-- DPI is being set to 96 on resize events. You can see this when running
	--
	--     WEZTERM_LOG=window::os::x11:connection=trace,wezterm_gui::termwindow::resize=trace,info wezterm-gui
	--
	-- The initial ("current") dimensions will show whatever DPI is set here
	-- in the wezterm configuration, but it will immediately be reset to 96 as
	-- part of the resize event, undoing the DPI value set here.
	--
	-- The WEZTERM_LOG value used above was taken from an issue on GitHub.
	--dpi = 192.0,

	enable_wayland = false,
	adjust_window_size_when_changing_font_size = false,

	colors = {
		foreground = color.foreground,
		background = color.background,
		cursor_fg = color.background,
		cursor_bg = color.foreground,
		cursor_border = color.background,
		selection_fg = color.emphasizedForeground,
		selection_bg = color.attention,
		ansi = {
			color.background,
			color.alert,
			color.inverseAccent,
			color.accent,
			color.hyper,
			color.major,
			color.super,
			color.inverseEmphasizedBackground,
		},
		brights = {
			color.emphasizedBackground,
			color.attention,
			color.deemphasizedForeground,
			color.inverseForeground,
			color.foreground,
			color.minor,
			color.emphasizedForeground,
			color.inverseBackground,
		},
		compose_cursor = color.attention,
	},
}
