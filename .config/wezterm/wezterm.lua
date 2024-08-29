local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.color_scheme = 'Argonaut'
config.font_size = 24.0
config.font = wezterm.font_with_fallback({
    { family = 'SeriousShanns Nerd Font Propo', weight = 'DemiBold' },
    { family = 'SeriousShanns Nerd Font Mono', weight = 'DemiBold' },
    { family = 'JetBrains Mono', weight = 'Regular' },
})

config.keys = {
    {
        key = 'LeftArrow',
        mods = 'OPT',
        -- ^[b
        action = wezterm.action({ SendString = '\x1bb' }),
    },
    {
        key = 'RightArrow',
        mods = 'OPT',
        -- ^[f
        action = wezterm.action({ SendString = '\x1bf' }),
    },
    {
        key = 'LeftArrow',
        mods = 'CMD',
        -- ^A
        action = wezterm.action({ SendString = '\x01' }),
    },
    {
        key = 'RightArrow',
        mods = 'CMD',
        -- ^E
        action = wezterm.action({ SendString = '\x05' }),
    },
}

config.colors = {
    cursor_bg = 'green',
    cursor_fg = 'black',
}

config.window_frame = {
    font_size = 24.0,
}

config.window_padding = {
    left = '1cell',
    right = '1cell',
    top = '0cell',
    bottom = '0cell',
}

config.scrollback_lines = 350000
config.enable_scroll_bar = true

return config
