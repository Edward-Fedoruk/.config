local config = {}
local wezterm = require 'wezterm';

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

-- tmux like setup
config.leader = { key = 'a', mods = 'CTRL', timeout_milliseconds = 1000 }

local function is_vim(pane)
    return pane:get_user_vars().IS_NVIM == 'true'
end

local function is_vim(pane)
    local process_name = string.gsub(pane:get_foreground_process_name(), '(.*[/\\])(.*)', '%2')
    return process_name == 'nvim' or process_name == 'vim'
end

local direction_keys = {
    h = 'Left',
    j = 'Down',
    k = 'Up',
    l = 'Right',
}

local function split_nav(resize_or_move, key)
    return {
        key = key,
        mods = resize_or_move == 'resize' and 'META' or 'CTRL',
        action = wezterm.action_callback(function(win, pane)
            if is_vim(pane) then
                win:perform_action({
                    SendKey = { key = key, mods = resize_or_move == 'resize' and 'META' or 'CTRL' },
                }, pane)
            else
                if resize_or_move == 'resize' then
                    win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
                else
                    win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
                end
            end
        end),
    }
end

config.keys = {
    -- splitting
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

    split_nav('move', 'h'),
    split_nav('move', 'j'),
    split_nav('move', 'k'),
    split_nav('move', 'l'),
    split_nav('resize', 'h'),
    split_nav('resize', 'j'),
    split_nav('resize', 'k'),
    split_nav('resize', 'l'),
}

return config
