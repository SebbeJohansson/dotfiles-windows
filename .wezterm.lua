-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
-- config.default_domain = 'WSL:Ubuntu'
-- config.default_prog = { 'powershell.exe', '-NoLogo' }
-- Launch WSL directly with proper shell
-- config.default_prog = { 'wsl.exe', '--cd', '~' }
-- config.default_prog = { 'wsl' }

-- Set the default domain to WSL
config.default_domain = 'WSL:Ubuntu'

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
  -- Move focus between panes (SHIFT + arrows)
  { key = 'LeftArrow',  mods = 'SHIFT', action = wezterm.action.ActivatePaneDirection 'Left' },
  { key = 'RightArrow', mods = 'SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'SHIFT', action = wezterm.action.ActivatePaneDirection 'Up' },
  { key = 'DownArrow',  mods = 'SHIFT', action = wezterm.action.ActivatePaneDirection 'Down' },

  -- Split panes (CTRL + arrows)
  { key = 'LeftArrow',  mods = 'CTRL', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'RightArrow', mods = 'CTRL', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'DownArrow',  mods = 'CTRL', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'UpArrow',    mods = 'CTRL', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  
  -- New tab (CTRL+T)
  { key = 't', mods = 'CTRL', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  
  -- Close pane (CTRL+W)
  {
    key = 'w',
    mods = 'CTRL',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },

  -- Resize panes (ALT + arrows)
  { key = 'LeftArrow',  mods = 'ALT', action = wezterm.action.AdjustPaneSize { 'Left', 1 } },
  { key = 'RightArrow', mods = 'ALT', action = wezterm.action.AdjustPaneSize { 'Right', 1 } },
  { key = 'UpArrow',    mods = 'ALT', action = wezterm.action.AdjustPaneSize { 'Up', 1 } },
  { key = 'DownArrow',  mods = 'ALT', action = wezterm.action.AdjustPaneSize { 'Down', 1 } },
}

-- Finally, return the configuration to wezterm:
return config