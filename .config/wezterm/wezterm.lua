local wezterm = require 'wezterm';
local smart_splits = wezterm.plugin.require('https://github.com/mrjones2014/smart-splits.nvim')

local config = wezterm.config_builder()

config.enable_csi_u_key_encoding = true

config.color_scheme = 'Catppuccin Macchiato'
config.window_background_opacity = 1
config.hide_tab_bar_if_only_one_tab = false
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

wezterm.on('update-right-status', function(window, pane)
    window:set_right_status(window:active_workspace())
end)

filter = function(tbl, callback)
    local filt_table = {}

    for i, v in ipairs(tbl) do
        if callback(v, i) then
            table.insert(filt_table, v)
        end
    end
    return filt_table
end

kill_workspace = function(workspace)
    local success, stdout =
        wezterm.run_child_process({ "/opt/homebrew/bin/wezterm", "cli", "list", "--format=json" })

    if success then
        local json = wezterm.json_parse(stdout)
        if not json then
            return
        end

        local workspace_panes = filter(json, function(p)
            return p.workspace == workspace
        end)

        for _, p in ipairs(workspace_panes) do
            wezterm.run_child_process({
                "/opt/homebrew/bin/wezterm",
                "cli",
                "kill-pane",
                "--pane-id=" .. p.pane_id,
            })
        end
    end
end

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
    {
        key = 'f',
        mods = 'LEADER',
        action = wezterm.action.ShowLauncherArgs {
            flags = 'FUZZY|WORKSPACES',
        },
    },
    {
        key = "k",
        mods = "LEADER",
        action = wezterm.action_callback(function(window)
            local w = window:active_workspace()
            kill_workspace(w)
        end),
    },
    {
        key = 'r',
        mods = 'LEADER',
        action = wezterm.action.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = 'Bold' } },
                { Foreground = { AnsiColor = 'Fuchsia' } },
                { Text = 'Enter new name for workspace' },
            },
            action = wezterm.action_callback(function(window, pane, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:perform_action(
                        wezterm.mux.rename_workspace(
                            wezterm.mux.get_active_workspace(),
                            line
                        )
                    )
                end
            end),
        },
    },
    {
        key = 'w',
        mods = 'LEADER',
        action = wezterm.action.PromptInputLine {
            description = wezterm.format {
                { Attribute = { Intensity = 'Bold' } },
                { Foreground = { AnsiColor = 'Fuchsia' } },
                { Text = 'Enter name for new workspace' },
            },
            action = wezterm.action_callback(function(window, pane, line)
                -- line will be `nil` if they hit escape without entering anything
                -- An empty string if they just hit enter
                -- Or the actual line of text they wrote
                if line then
                    window:perform_action(
                        wezterm.action.SwitchToWorkspace {
                            name = line,
                        },
                        pane
                    )
                end
            end),
        },
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
