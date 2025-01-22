local wezterm = require 'wezterm';
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')

local config = wezterm.config_builder()

config.enable_csi_u_key_encoding = true

config.color_scheme = 'Catppuccin Macchiato'
config.window_background_opacity = 1
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
    active_titlebar_bg = '#1e1e2f'
}
config.macos_window_background_blur = 100
config.window_background_image_hsb = {
    brightness = 0.05,
    hue = 1.0,
    saturation = 1.0,
}
config.window_padding = {
    left = 2,
    right = 2,
    top = 2,
    bottom = 2,
}
config.font_size = 14.0

config.keys = {
    {
        key = 'Enter',
        mods = 'LEADER',
        action = wezterm.action.ActivateCopyMode
    },
    {
        mods   = "LEADER",
        key    = "-",
        action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' }
    },
    {
        mods   = "LEADER",
        key    = "|",
        action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' }
    },
    {
        mods = 'LEADER',
        key = 'm',
        action = wezterm.action.TogglePaneZoomState
    },

    -- Remap Option + Left Arrow to Alt + B (backward-word)
    { key = "LeftArrow",  mods = "OPT", action = wezterm.action { SendKey = { key = "b", mods = "ALT" } } },

    -- Remap Option + Right Arrow to Alt + F (forward-word)
    { key = "RightArrow", mods = "OPT", action = wezterm.action { SendKey = { key = "f", mods = "ALT" } } },
}

config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

-- you can put the rest of your Wezterm config here
smart_splits.apply_to_config(config, {
    direction_keys = {
        move = { 'h', 'j', 'k', 'l' },
        resize = { 'LeftArrow', 'DownArrow', 'UpArrow', 'RightArrow' },
    },
    modifiers = {
        move = 'CTRL',   -- modifier to use for pane movement, e.g. CTRL+h to move left
        resize = 'META', -- modifier to use for pane resize, e.g. META+h to resize to the left
    },
    log_level = 'info',
})


return config
