-- Monitor wiki https://wiki.hypr.land/Configuring/Basics/Monitors/
-- Example: output can be found with hyprctl monitors. Edit variables.lua for the monitor outputs instead of here directly
-- hl.monitor({
--     output    = "MONITOR1",
--     mode      = "1920x1080@60",
--     position  = "0x0",
--     scale     = "1",
-- })

-- Layout ported from debian/config/hypr/monitors.conf (Acer centered/primary,
-- Lenovo + LG rotated to portrait flanking it)
hl.monitor({
    output    = MONITOR1,
    mode      = "3840x2160@160.0",
    position  = "1080x0",
    scale     = 1.25,
})

hl.monitor({
    output    = MONITOR2,
    mode      = "2560x1440@74.78",
    position  = "4152x0",
    scale     = 1.0,
    transform = 3,
})

hl.monitor({
    output    = MONITOR3,
    mode      = "1920x1080@60.00",
    position  = "0x0",
    scale     = 1.0,
    transform = 1,
})
