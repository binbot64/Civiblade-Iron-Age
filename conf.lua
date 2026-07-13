-- LÖVE2D Configuration
-- Defines window settings and LÖVE framework modules

function love.conf(t)
    t.title = "CiviBlade: Iron Age"
    t.window.width = 1280
    t.window.height = 720
    t.window.msaa = 4  -- Anti-aliasing for smoother graphics
    t.window.resizable = true
    t.window.vsync = 1  -- Enable vertical sync (60 FPS)
    t.version = "11.4"  -- LÖVE framework version
    
    -- Enable/disable modules as needed
    t.modules.joystick = true
    t.modules.keyboard = true
    t.modules.mouse = true
    t.modules.sound = false  -- Enable later with audio system
    t.modules.graphics = true
    t.modules.window = true
    t.modules.timer = true
    t.modules.filesystem = true
    t.modules.data = true
end
