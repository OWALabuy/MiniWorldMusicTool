--[[
    玩家会话管理器
    负责每个玩家的状态数据管理
]]

local PlayerSession = {}
PlayerSession.__index = PlayerSession

local sessions = {}  -- UIN -> session

-- 创建玩家会话
function PlayerSession:CreateSession(UIN)
    if sessions[UIN] then
        return sessions[UIN]  -- 已存在，返回现有会话
    end
    
    local session = {
        UIN = UIN,
        state = nil,  -- 由StateMachine管理
        currentTool = nil,  -- 当前手持道具ID
        currentFlow = nil,  -- 当前活跃流程（由StateMachine管理）
        
        -- 玩家数据（兼容原有PDB结构）
        data = {
            -- 音调方块相关
            toneBlock = nil,
            
            -- 乐器方块相关
            instrumentBlock = {
                id = nil,
                clickNum = nil,
            },
            instrumentGroup = {
                toneId = nil,
                toneClickNum = nil,
            },
            instrumentSwitch = false,  -- 平凡法杖开关
            
            -- 刷子相关
            brush = {
                enabled = false,
                size = 2,
            },
            
            -- 复制粘贴相关
            copy = {
                pos = {
                    strpos = nil,
                    endpos = nil,
                },
                vector = nil,
                direction = nil,
                areadata = nil,
                way = 1,  -- 粘贴方式
                LastPastePos = nil,
            },
            
            -- Pattern相关
            pattern = {
                nowPatId = -1,
                lastPasPatId = -1,
                LastPastePatPos = nil,
                renameId = -1,
            },
            
            -- AreaPAT相关
            areaPAT = {
                pos = {
                    strpos = nil,
                    endpos = nil,
                },
                vector = nil,
                direction = nil,
                nowPatId = -1,
                lastPasPatId = -1,
                LastPastePatPos = nil,
                way = 1,
                renameId = -1,
            },
            
            -- 鼓方块相关
            drum = {
                mode = "tone",  -- "tone" 或 "instrument"
            },
            
            -- 其他临时数据
            temp = {},
        },
    }
    
    sessions[UIN] = session
    return session
end

-- 获取玩家会话
function PlayerSession:GetSession(UIN)
    return sessions[UIN]
end

-- 销毁玩家会话
function PlayerSession:DestroySession(UIN)
    sessions[UIN] = nil
end

-- 获取所有会话（用于清理等操作）
function PlayerSession:GetAllSessions()
    return sessions
end

-- 检查会话是否存在
function PlayerSession:HasSession(UIN)
    return sessions[UIN] ~= nil
end

-- 获取玩家数据（兼容原有PDB[UIN]访问方式）
function PlayerSession:GetData(UIN)
    local session = self:GetSession(UIN)
    return session and session.data or nil
end

-- 设置玩家数据
function PlayerSession:SetData(UIN, key, value)
    local session = self:GetSession(UIN)
    if session then
        session.data[key] = value
    end
end

-- 获取玩家状态
function PlayerSession:GetState(UIN)
    local session = self:GetSession(UIN)
    return session and session.state or nil
end

-- 设置玩家状态
function PlayerSession:SetState(UIN, state)
    local session = self:GetSession(UIN)
    if session then
        session.state = state
    end
end

-- 获取当前工具
function PlayerSession:GetCurrentTool(UIN)
    local session = self:GetSession(UIN)
    return session and session.currentTool or nil
end

-- 设置当前工具
function PlayerSession:SetCurrentTool(UIN, itemId)
    local session = self:GetSession(UIN)
    if session then
        session.currentTool = itemId
    end
end

return PlayerSession

