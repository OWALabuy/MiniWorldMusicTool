--[[
    常量定义
    集中管理所有硬编码的数值和ID
]]

local Constants = {}

-- 道具ID
Constants.ItemId = {
    -- 音调方块
    TONE_LOW = 690,      -- 低音块
    TONE_MID = 691,      -- 中音块
    TONE_HIGH = 692,     -- 高音块
    
    -- 工具
    ORDINARY_WAND = 11580,    -- 平凡法杖
    REAPER = 12009,           -- 收割者
    TITANIUM_RAKE = 12010,    -- 钛合金耙
    REVIVAL_STAFF = 11584,    -- 复苏法杖
    THUNDER_STAFF = 11582,    -- 雷电法杖
    FRIGID_STAFF = 11583,     -- 极寒域法杖
    FIERY_STAFF = 11585,      -- 炽烈法杖
    ICE_STAFF = 11586,        -- 冰魄法杖
    HORAS_DRILL = 11016,      -- 星铜钻头
    GIANT_CORE = 12011,       -- 巨人核心
    ROBOT_ARM = 12012,        -- 推拉机械臂
    ROLLER_COASTER = 12013,   -- 过山车头
    STONE_ARROW = 12014,      -- 石箭
    PULSE_ARROW = 12015,      -- 脉冲箭
    
    -- 乐器方块
    DRUM = 693,           -- 鼓
    ELECTRONIC = 694,     -- 电子
    COMPOSITE = 695,      -- 综合
    
    -- 初始道具列表
    INITIAL_ITEMS = {
        690, 691, 692,    -- 音调方块
        11580,            -- 平凡法杖
        693, 694, 695,    -- 乐器方块
        12009,            -- 收割者
        -- ... 其他道具
    },
}

-- 方块ID
Constants.BlockId = {
    AIR = 0,
    BEAM_LINE = 351,     -- 光束线
    
    -- 音调方块范围
    TONE_BLOCK_MIN = 690,
    TONE_BLOCK_MAX = 692,
    
    -- 透明玻璃块（封轨用）
    TRANSPARENT_GLASS = 632,
}

-- 特效ID
Constants.EffectId = {
    COPY = 1212,         -- 复制特效
    PLACE = 1005,        -- 放置特效
}

-- 数值常量
Constants.Values = {
    -- 音调相关
    TONE_MIN_CLICK = 0,
    TONE_MAX_CLICK = 12,
    
    -- 刷子相关
    BRUSH_MIN_SIZE = 1,
    BRUSH_MAX_SIZE = 10,
    BRUSH_DEFAULT_SIZE = 2,
    
    -- 流程超时（秒）
    FLOW_TIMEOUT = 60,
    
    -- 位置偏移默认值
    OFFSET_DEFAULT = {x = 0, y = 0, z = 0},
}

-- 颜色代码（用于聊天消息）
Constants.Color = {
    WHITE = "#cFFFFFF",
    YELLOW = "#Y",
    RED = "#R",
    -- ... 可以从原代码中提取所有颜色代码
}

return Constants

