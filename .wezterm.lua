-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
-- config.default_domain = 'WSL:Ubuntu'
config.default_prog = { 'powershell.exe', '-NoLogo' }

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

-- or, changing the font size and color scheme.
config.font_size = 10
config.color_scheme = 'AdventureTime'

-- Tab settings
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = true

-- Keys
config.keys = {
  -- Move focus between panes (CTRL+SHIFT)
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },

  -- Split panes (CTRL+SHIFT+ALT)
  { key = 'LeftArrow',  mods = 'CTRL|SHIFT|ALT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'DownArrow',  mods = 'CTRL|SHIFT|ALT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },

  -- Resize panes (CTRL+ALT)
  { key = 'LeftArrow',  mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize { 'Left', 1 } },
  { key = 'RightArrow', mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize { 'Right', 1 } },
  { key = 'UpArrow',    mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize { 'Up', 1 } },
  { key = 'DownArrow',  mods = 'CTRL|ALT', action = wezterm.action.AdjustPaneSize { 'Down', 1 } },
}

-- Finally, return the configuration to wezterm:
return config