-- main.lua
-- Entry point and main game loop for CiviBlade: Iron Age
-- Coordinates between all game systems

local Constants = require("core.constants")
local Utils = require("core.utils")

-- Game state container
local Game = {
    running = true,
    deltaTime = 0,
    totalTime = 0,
    fps = 0,
    fpsCounter = 0,
}

--- Initialize the game
function love.load()
    Utils.info("=== CiviBlade: Iron Age ===")
    Utils.info("Initializing game systems...")
    
    -- Set window properties
    love.window.setTitle("CiviBlade: Iron Age")
    love.window.setMode(Constants.WINDOW_WIDTH, Constants.WINDOW_HEIGHT, {
        resizable = true,
        vsync = 1,
    })
    
    -- Set random seed for world generation
    math.randomseed(Constants.WORLD_SEED)
    Utils.info("Random seed: " .. Constants.WORLD_SEED)
    
    -- Initialize game state
    Game.world = nil          -- Will be initialized when entering main game
    Game.player = nil         -- Player entity
    Game.camera = nil         -- Camera system
    Game.gameState = "menu"   -- Current game state: "menu", "loading", "playing", "paused"
    
    Utils.info("Game initialized successfully!")
    Utils.log("Press SPACE to start or check the console for debug info", "INFO")
end

--- Update game logic (called every frame)
function love.update(dt)
    Game.deltaTime = dt
    Game.totalTime = Game.totalTime + dt
    
    -- Update FPS counter
    Game.fpsCounter = Game.fpsCounter + dt
    if Game.fpsCounter >= 0.5 then
        Game.fps = math.floor(1 / dt)
        Game.fpsCounter = 0
    end
    
    -- Handle game states
    if Game.gameState == "menu" then
        updateMenu(dt)
    elseif Game.gameState == "loading" then
        updateLoading(dt)
    elseif Game.gameState == "playing" then
        updateGame(dt)
    elseif Game.gameState == "paused" then
        updatePaused(dt)
    end
end

--- Render the game
function love.draw()
    love.graphics.clear(0.1, 0.1, 0.1)  -- Dark background
    
    if Game.gameState == "menu" then
        drawMenu()
    elseif Game.gameState == "loading" then
        drawLoading()
    elseif Game.gameState == "playing" then
        drawGame()
    elseif Game.gameState == "paused" then
        drawPaused()
    end
    
    -- Draw debug info
    drawDebugInfo()
end

--- Handle keyboard input
function love.keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "space" and Game.gameState == "menu" then
        startGame()
    elseif key == "p" and Game.gameState == "playing" then
        Game.gameState = "paused"
    elseif key == "p" and Game.gameState == "paused" then
        Game.gameState = "playing"
    elseif key == "f11" then
        -- Toggle fullscreen
        local flags = love.window.getMode()
        love.window.setMode(Constants.WINDOW_WIDTH, Constants.WINDOW_HEIGHT, {
            fullscreen = not flags.fullscreen,
            resizable = true,
            vsync = 1,
        })
    end
end

--- Handle window resize
function love.resize(w, h)
    -- Could update camera or UI here
    Utils.info("Window resized to " .. w .. "x" .. h)
end

-- ===== MENU STATE =====

function updateMenu(dt)
    -- Menu doesn't need frame-by-frame updates yet
end

function drawMenu()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("CiviBlade: Iron Age", 0, Constants.WINDOW_HEIGHT / 2 - 100, Constants.WINDOW_WIDTH, "center")
    love.graphics.setFont(love.graphics.newFont(16))
    love.graphics.printf("Press SPACE to Start", 0, Constants.WINDOW_HEIGHT / 2, Constants.WINDOW_WIDTH, "center")
    love.graphics.printf("Press ESC to Quit", 0, Constants.WINDOW_HEIGHT / 2 + 50, Constants.WINDOW_WIDTH, "center")
end

-- ===== LOADING STATE =====

function updateLoading(dt)
    -- Placeholder for loading logic
    -- In future, this will load chunks, initialize world, etc.
    Utils.info("Loading game world...")
    Game.gameState = "playing"
end

function drawLoading()
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("Loading...", 0, Constants.WINDOW_HEIGHT / 2, Constants.WINDOW_WIDTH, "center")
end

-- ===== GAME STATE =====

function updateGame(dt)
    -- Placeholder for main game loop updates
    -- Will update: player, world, entities, AI, etc.
end

function drawGame()
    -- Placeholder for game rendering
    -- Will draw: world, entities, UI, etc.
    love.graphics.setColor(0.2, 0.4, 0.2, 1)
    love.graphics.rectangle("fill", 0, 0, Constants.WINDOW_WIDTH, Constants.WINDOW_HEIGHT)
    
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("Game World (coming soon)", 0, Constants.WINDOW_HEIGHT / 2, Constants.WINDOW_WIDTH, "center")
end

-- ===== PAUSED STATE =====

function updatePaused(dt)
    -- Paused state doesn't update game logic
end

function drawPaused()
    -- Draw the game world but with a pause overlay
    drawGame()
    
    -- Semi-transparent overlay
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", 0, 0, Constants.WINDOW_WIDTH, Constants.WINDOW_HEIGHT)
    
    -- Pause text
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.setFont(love.graphics.newFont(32))
    love.graphics.printf("PAUSED", 0, Constants.WINDOW_HEIGHT / 2 - 50, Constants.WINDOW_WIDTH, "center")
    love.graphics.setFont(love.graphics.newFont(16))
    love.graphics.printf("Press P to Resume", 0, Constants.WINDOW_HEIGHT / 2 + 20, Constants.WINDOW_WIDTH, "center")
end

-- ===== HELPER FUNCTIONS =====

function startGame()
    Utils.info("Starting new game...")
    Game.gameState = "loading"
    -- World and player initialization will happen in updateLoading
end

function drawDebugInfo()
    love.graphics.setColor(1, 1, 1, 0.8)
    love.graphics.setFont(love.graphics.newFont(12))
    
    local debugText = string.format(
        "FPS: %d | DT: %.3f | Time: %.1f\nState: %s | Seed: %d",
        Game.fps,
        Game.deltaTime,
        Game.totalTime,
        Game.gameState,
        Constants.WORLD_SEED
    )
    
    love.graphics.print(debugText, 10, 10)
end

-- ===== EXPORTS =====
-- Allow other modules to access game state
_G.Game = Game
