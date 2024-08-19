local wezterm = require('wezterm')
local config = wezterm.config_builder()

config.color_scheme = 'Argonaut'
config.font_size = 24.0
config.font = wezterm.font_with_fallback({
    'SeriousShanns Nerd Font Mono',
    -- 'SeriousShanns Nerd Font Propo',
    'JetBrains Mono',
})

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
