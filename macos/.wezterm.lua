local wezterm = require "wezterm"
local config = wezterm.config_builder()

config.color_scheme = "Apple System Colors"
config.font = wezterm.font({ family = "Menlo" })
config.font_size = 12
config.freetype_load_flags = "NO_HINTING"
config.freetype_load_target = "Light"
config.freetype_render_target = "HorizontalLcd"
config.cell_width = 0.9

config.window_decorations = "RESIZE|INTEGRATED_BUTTONS"

config.keys = {
    {   
        key = "Home",
        action = wezterm.action.SendString "\x1bb",
    },
    {   
        key = "End",
        action = wezterm.action.SendString "\x1bf",
    },
    {
        key = "f",
        mods = "CMD|CTRL",
        action = wezterm.action.ToggleFullScreen,
    }
}

for i = 1, 8 do
    table.insert(config.keys, {
        key = tostring(i),
        mods = "CTRL|ALT",
        action = wezterm.action.ActivateTab(i - 1),
    })
    table.insert(config.keys, {
        key = tostring(i),
        mods = "CTRL|CMD",
        action = wezterm.action.MoveTab(i - 1),
    })
end

local function segments_for_right_status(window, pane)
    local cells = {}
    local cwd_uri = pane:get_current_working_dir()

    if cwd_uri then
        local cwd = ""
        local hostname = ""

        if type(cwd_uri) == "userdata" then
            cwd = cwd_uri.file_path
            hostname = cwd_uri.host or wezterm.hostname()
        else
            cwd_uri = cwd_uri:sub(8)
            local slash = cwd_uri:find "/"
            if slash then
                hostname = cwd_uri:sub(1, slash - 1)
                cwd = cwd_uri:sub(slash):gsub("%%(%x%x)", function(hex)
                    return string.char(tonumber(hex, 16))
                end)
            end
        end

        local dot = hostname:find "[.]"
        if dot then
            hostname = hostname:sub(1, dot - 1)
        end
        if hostname == "" then
            hostname = wezterm.hostnam()
        end

        table.insert(cells, cwd)
        table.insert(cells, hostname)
    end
        
    local date = wezterm.strftime "%a %-d %b %H:%M"
    table.insert(cells, date)

    for _, b in ipairs(wezterm.battery_info()) do
        table.insert(cells, string.format("%.0f%%", b.state_of_charge * 100))
    end

    return cells 
end

wezterm.on("update-status", function(window, pane)
    local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
    local segments = segments_for_right_status(window, pane)

    local color_scheme = window:effective_config().resolved_palette
    local bg = wezterm.color.parse(color_scheme.background)
    local fg = color_scheme.foreground

    local gradient_to, gradient_from = bg
    gradient_from = gradient_to:lighten(0.2)

    local gradient = wezterm.color.gradient(
        {
            orientation = "Horizontal",
            colors = { gradient_from, gradient_to },
        },
        #segments
    )

    local elements = {}

    for i, seg in ipairs(segments) do
        local is_first = i == 1

        if is_first then
            table.insert(elements, { Background = { Color = "none" } })
        end
        table.insert(elements, { Foreground = { Color = gradient[i] } })
        table.insert(elements, { Text = SOLID_LEFT_ARROW })

        table.insert(elements, { Foreground = { Color = fg } })
        table.insert(elements, { Background = { Color = gradient[i] } })
        table.insert(elements, { Text = " " .. seg .. " " })
    end

    window:set_right_status(wezterm.format(elements))
end)

return config

