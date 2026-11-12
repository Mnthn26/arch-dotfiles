-- Hyprland Lua Configuration

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

local terminal = "kitty"
local menu = "wofi --show drun"
local mainMod = "SUPER"

hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,
        border_size = 0,
        layout = "dwindle"
    },
    decoration = {
        rounding = 0,
        blur = { enabled = false }
    },
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        touchpad = { natural_scroll = true }
    }
})

-- Core bindings
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())

-- Workspaces 1-10 (key 0 = workspace 10)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Focus with Super + H/J/K/L
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move windows with Super + arrows
hl.bind(mainMod .. " + left", function() hl.exec_cmd("hyprctl dispatch movewindow l") end)
hl.bind(mainMod .. " + right", function() hl.exec_cmd("hyprctl dispatch movewindow r") end)
hl.bind(mainMod .. " + up", function() hl.exec_cmd("hyprctl dispatch movewindow u") end)
hl.bind(mainMod .. " + down", function() hl.exec_cmd("hyprctl dispatch movewindow d") end)

-- Mouse drag / resize
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Volume + brightness keys (with on-screen progress bar via SwayOSD)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"), { locked = true, repeating = true })

-- Media playback keys
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

-- Screenshot to clipboard

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("waybar")
    hl.exec_cmd("kitty")
end)

-- ===== Extras =====
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("swaylock -f -c 000000"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))

hl.on("hyprland.start", function()
    hl.exec_cmd("mako")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("swayidle -w timeout 300 'swaylock -f -c 000000' before-sleep 'swaylock -f -c 000000'")
end)

-- ===== Random wallpaper =====
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/wallpaper.sh"))

hl.on("hyprland.start", function()
    hl.exec_cmd("~/.config/hypr/wallpaper-loop.sh")
end)

-- ===== Looks =====
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(89b4faff)", "rgba(cba6f7ff)" }, angle = 45 },
            inactive_border = "rgba(313244aa)"
        }
    },
    decoration = {
        rounding = 10,
        blur = {
            enabled = true,
            size = 6,
            passes = 2
        }
    }
})

hl.curve("easeOut", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.0} } })
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "easeOut", style = "slide" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "easeOut" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "easeOut", style = "slide" })


-- ===== App shortcuts =====
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("google-chrome-stable --ozone-platform-hint=auto"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("spotify-launcher"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("code --ozone-platform-hint=auto"))

-- ===== Visual Polish =====
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = { colors = { "rgba(89b4faff)", "rgba(cba6f7ff)" }, angle = 45 },
            inactive_border = "rgba(313244aa)"
        }
    },
    decoration = {
        rounding = 10,
        blur = {
            enabled = true,
            size = 6,
            passes = 2
        }
    }
})

hl.curve("easeOut", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.0} } })
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "easeOut", style = "slide" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "easeOut" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "easeOut", style = "slide" })

-- ===== Window Rules =====
-- Make floating windows default for utilities and dialogs
hl.config({
    windowrulev2 = {
        { rule = "float", match = { class = "pavucontrol" } },
        { rule = "float", match = { class = "blueman-manager" } },
        { rule = "float", match = { class = "nm-connection-editor" } },
        { rule = "float", match = { class = "xdg-desktop-portal-gtk" } }
    }
})

-- ===== Screenshots & Recording =====
-- Region screenshot: Select area, copy to clipboard, and save
hl.bind("Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" - | tee ~/Pictures/shot-$(date +%s).png | wl-copy && notify-send 'Screenshot' 'Region copied to clipboard & saved'"))

-- Full screen screenshot (Print + Enter or using a combined trigger): 
-- Captures entire screen, copies to clipboard, and saves
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grim - | tee ~/Pictures/shot-full-$(date +%s).png | wl-copy && notify-send 'Screenshot' 'Full screen copied to clipboard & saved'"))

-- Screen video recording toggle using Shift + Print
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("if pgrep wf-recorder; then pkill wf-recorder && notify-send 'Recorder' 'Stopped & saved video'; else wf-recorder -f ~/Pictures/recording-$(date +%s).mp4 & notify-send 'Recorder' 'Started recording screen'; fi"))

-- ===== Touchpad Gestures =====
-- Horizontal 3-finger swipe to switch workspaces
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Tune workspace swipe behavior (optional, adjust values to taste)
hl.config({
    gestures = {
        workspace_swipe_distance = 300, -- pixels; default is 300[reference:1]
        workspace_swipe_cancel_ratio = 0.15,
        workspace_swipe_invert = false -- set to true if you prefer natural scroll direction
    }
})

-- ===== Load hyprpm plugins on startup =====
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpm reload")
end)

-- ===== Hyprspace Overview =====
-- Toggle overview with Super + G
hl.bind("SUPER + G", hl.dsp.exec_cmd("hyprctl dispatch overview:toggle"))

-- 3-finger swipe up to toggle overview
hl.gesture({
    fingers = 3,
    direction = "up",
    action = function()
        hl.exec_cmd("hyprctl dispatch overview:toggle")
    end
})

-- Plugin configuration (panel layout and spacing)
hl.config({
    plugin = {
        overview = {
            panelHeight = 220,
            panelBorderWidth = 3,
            workspaceMargin = 12,
            reservedArea = 0
        }
    }
})

-- Ensure plugins are loaded on startup
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpm reload")
end)

-- Alternative gesture direction if "up" doesn't work
hl.gesture({
    fingers = 3,
    direction = "down",
    action = function()
        hl.exec_cmd("hyprctl dispatch overview:toggle")
    end
})

-- ===== Kitty Terminal Window Rule =====
-- Sets 92% opacity for active and 85% for inactive windows
hl.window_rule({
    match = { class = "kitty" },
    opacity = "0.92 0.85"
})
