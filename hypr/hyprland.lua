-- ==========================================
-- 1. Variables & Monitor
-- ==========================================
local terminal = "kitty"
local menu = "wofi --show drun"
local mainMod = "SUPER"

hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

-- ==========================================
-- 2. Core Configuration
-- ==========================================
hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        layout = "dwindle",
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
    },
    input = {
        kb_layout = "us",
        follow_mouse = 1,
        touchpad = {
            natural_scroll = true,
            scroll_factor = 0.4
        }
    },
    gestures = {
        workspace_swipe_distance = 300,
        workspace_swipe_cancel_ratio = 0.15,
        workspace_swipe_invert = false
    }
})

-- ==========================================
-- 3. Animations
-- ==========================================
hl.curve("easeOut", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.0} } })
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "easeOut", style = "slide" })
hl.animation({ leaf = "fade", enabled = true, speed = 5, bezier = "easeOut" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "easeOut", style = "slide" })

-- ==========================================
-- 4. Window Rules
-- ==========================================
hl.window_rule({
    match = { class = "kitty" },
    opacity = "0.92 0.85"
})

-- ==========================================
-- 5. Keybindings
-- ==========================================
-- Core binds
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("hyprlock"))

-- Workspaces 1-10 (key 0 = workspace 10)
for i = 1, 10 do
    local key = i % 10
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Focus and Move
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + left", function() hl.exec_cmd("hyprctl dispatch movewindow l") end)
hl.bind(mainMod .. " + right", function() hl.exec_cmd("hyprctl dispatch movewindow r") end)
hl.bind(mainMod .. " + up", function() hl.exec_cmd("hyprctl dispatch movewindow u") end)
hl.bind(mainMod .. " + down", function() hl.exec_cmd("hyprctl dispatch movewindow d") end)

-- Mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media & Hardware
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("swayosd-client --output-volume raise"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("swayosd-client --output-volume lower"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("swayosd-client --output-volume mute-toggle"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("swayosd-client --input-volume mute-toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("swayosd-client --brightness raise"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("swayosd-client --brightness lower"), { locked = true, repeating = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

-- Utilities
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grim -g \"$(slurp)\" ~/Pictures/shot-$(date +%s).png"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("thunar"))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd("cliphist list | wofi --dmenu | cliphist decode | wl-copy"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/hypr/wallpaper.sh"))
hl.bind(mainMod .. " + G", hl.dsp.exec_cmd("hyprctl dispatch overview:toggle"))

-- App Shortcuts

-- ==========================================
-- 6. Gestures
-- ==========================================
-- Workspace switching
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Hyprspace Overview
hl.gesture({
    fingers = 3,
    direction = "up",
    action = function()
        hl.exec_cmd("hyprctl dispatch overview:toggle")
    end
})

-- ==========================================
-- 7. Plugin Configuration (Hyprspace)
-- ==========================================
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

-- ==========================================
-- 8. Autostart (Single Consolidated Block)
-- ==========================================
hl.on("hyprland.start", function()
    -- System Daemons & Panels
    hl.exec_cmd("swayosd-server")
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("wl-paste --watch cliphist store")
    hl.exec_cmd("swayidle -w timeout 300 'hyprlock' before-sleep 'hyprlock'")
    
    -- Wallpaper
    hl.exec_cmd("~/.config/hypr/wallpaper-loop.sh")
    
    -- Plugins
    hl.exec_cmd("hyprpm reload")
    
    -- Terminal
    hl.exec_cmd(terminal)
end)

-- ===== Updated App Shortcuts & Window Controls =====
-- Super + C for Chrome
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("google-chrome-stable --ozone-platform-hint=auto"))
-- Super + V for VS Code
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("code --ozone-platform-hint=auto"))
-- Super + S for Spotify
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("spotify-launcher"))
-- Super + F to toggle floating (moved from V)
hl.bind(mainMod .. " + F", hl.dsp.window.float({ action = "toggle" }))

-- ===== Super + Print Screen (Full screen to clipboard) =====

-- ===== Super + Print Screen (Full screen to clipboard + notification) =====
-- -t 20000 means the notification lasts 20 seconds (20000 milliseconds)
-- -i camera-photo adds a nice camera icon to the notification

-- ===== Super + Print Screen (Full screen to clipboard + countdown notification) =====
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd("grim - | wl-copy && ~/.config/hypr/screenshot-notify.sh"))

-- ===== Cursor Theme (Catppuccin Mocha) =====
-- Sets the cursor for Hyprland's native tools
hl.env("HYPRCURSOR_THEME", "catppuccin-mocha")
hl.env("HYPRCURSOR_SIZE", "24")

-- Sets the cursor for XWayland and GTK applications
hl.env("XCURSOR_THEME", "catppuccin-mocha")
hl.env("XCURSOR_SIZE", "24")

-- Force GTK Theme
hl.env("GTK_THEME", "catppuccin-mocha-blue-standard+default")

-- ===== Window Rules for Utility Apps =====
-- Float and center common system utilities

-- Volume Control
hl.window_rule({
    match = { class = "^(pavucontrol)$" },
    float = true,
    size = "800 600",
    center = true
})

-- Bluetooth Manager
hl.window_rule({
    match = { class = "^(blueman-manager)$" },
    float = true,
    size = "800 600",
    center = true
})

-- Network Connection Editor
hl.window_rule({
    match = { class = "^(nm-connection-editor)$" },
    float = true,
    size = "800 600",
    center = true
})

-- File Picker / Portal dialogs
hl.window_rule({
    match = { title = "^(Open File|Save File|Choose File)$" },
    float = true,
    center = true
})

-- ===== Gamemode Toggle =====
hl.bind(mainMod .. " + SHIFT + G", hl.dsp.exec_cmd("~/.config/hypr/gamemode.sh"))

-- ===== Screenshot with Swappy Annotation =====
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | swappy -f -'))
