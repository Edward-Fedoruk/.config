local config = {}
local wezterm = require 'wezterm';

config.enable_csi_u_key_encoding = true

config.keys = {
    -- Remap Option + Left Arrow to Alt + B (backward-word)
    { key = "LeftArrow", mods = "OPT", action = wezterm.action { SendKey = { key = "b", mods = "ALT" } } },

    -- Remap Option + Right Arrow to Alt + F (forward-word)
    { key = "RightArrow", mods = "OPT", action = wezterm.action { SendKey = { key = "f", mods = "ALT" } } },
}

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
return config
