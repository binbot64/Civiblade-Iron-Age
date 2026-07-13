-- core/constants.lua
-- Global game constants and configuration values
-- Keep all magic numbers here for easy balancing

local Constants = {}

-- ===== WINDOW & DISPLAY =====
Constants.WINDOW_WIDTH = 1280
Constants.WINDOW_HEIGHT = 720
Constants.TARGET_FPS = 60

-- ===== WORLD & CHUNK SYSTEM =====
Constants.CHUNK_SIZE = 16  -- Tiles per chunk (16x16)
Constants.TILE_SIZE = 32   -- Pixels per tile
Constants.RENDER_DISTANCE = 3  -- Chunks to render around player (radius)
Constants.UNLOAD_DISTANCE = 5  -- Distance before chunks unload

-- ===== WORLD GENERATION =====
Constants.WORLD_SEED = os.time()  -- Default seed (overridable)
Constants.SEA_LEVEL = 64
Constants.MOUNTAIN_HEIGHT = 128
Constants.CAVE_THRESHOLD = 0.4  -- Perlin noise threshold for caves

-- ===== PLAYER =====
Constants.PLAYER_MOVE_SPEED = 150  -- Pixels per second
Constants.PLAYER_WIDTH = 24
Constants.PLAYER_HEIGHT = 32
Constants.PLAYER_MAX_HEALTH = 100
Constants.PLAYER_MAX_HUNGER = 100
Constants.PLAYER_MAX_STAMINA = 100

-- ===== TOOLS & MINING =====
Constants.TOOL_BREAK_SPEED = {
    hand = 1.0,     -- 1x speed with bare hands
    wooden = 2.0,   -- 2x speed with wooden tools
    stone = 4.0,    -- 4x speed with stone tools
    copper = 6.0,
    bronze = 8.0,
    iron = 12.0,
    steel = 16.0,
}

-- ===== BLOCK HARDNESS (time in seconds to mine) =====
Constants.BLOCK_HARDNESS = {
    dirt = 0.5,
    grass = 0.6,
    stone = 1.5,
    cobblestone = 1.5,
    sand = 0.5,
    gravel = 0.6,
    coal_ore = 3.0,
    copper_ore = 3.5,
    iron_ore = 4.5,
    gold_ore = 5.0,
    diamond_ore = 8.0,
    wood = 1.0,
    leaves = 0.2,
}

-- ===== INVENTORY =====
Constants.INVENTORY_SIZE = 36  -- 9x4 grid
Constants.HOTBAR_SIZE = 9
Constants.STACK_SIZE_DEFAULT = 64
Constants.STACK_SIZE_UNSTACKABLE = 1

-- ===== CRAFTING =====
Constants.CRAFTING_GRID_WIDTH = 3
Constants.CRAFTING_GRID_HEIGHT = 3

-- ===== VILLAGERS =====
Constants.VILLAGER_SPAWN_RATE = 0.01  -- Probability per second to spawn new villager
Constants.VILLAGER_MIN_HAPPINESS = 0
Constants.VILLAGER_MAX_HAPPINESS = 100
Constants.VILLAGER_LIFESPAN = 100 * 365 * 24  -- ~100 years in game seconds (assuming days pass quickly)

-- ===== TIME & SEASONS =====
Constants.SECONDS_PER_DAY = 1200  -- 20 real seconds = 1 game day
Constants.DAYS_PER_MONTH = 30
Constants.MONTHS_PER_YEAR = 12
Constants.DAYS_PER_YEAR = Constants.DAYS_PER_MONTH * Constants.MONTHS_PER_YEAR

-- Season ranges (months 1-12)
Constants.SEASONS = {
    spring = { start = 1, end_ = 3 },
    summer = { start = 4, end_ = 6 },
    autumn = { start = 7, end_ = 9 },
    winter = { start = 10, end_ = 12 },
}

-- ===== COMBAT =====
Constants.MELEE_RANGE = 48  -- Pixels
Constants.PROJECTILE_SPEED = 300  -- Pixels per second
Constants.ATTACK_COOLDOWN = 0.5  -- Seconds between attacks

-- ===== COLORS (RGBA) =====
Constants.COLORS = {
    white = { 1, 1, 1, 1 },
    black = { 0, 0, 0, 1 },
    red = { 1, 0, 0, 1 },
    green = { 0, 1, 0, 1 },
    blue = { 0, 0, 1, 1 },
    yellow = { 1, 1, 0, 1 },
    gray = { 0.5, 0.5, 0.5, 1 },
    dark_gray = { 0.25, 0.25, 0.25, 1 },
    transparent = { 1, 1, 1, 0 },
}

return Constants
