--[[
    状态机核心引擎
    负责状态转换、流程管理、事件分发
]]

local StateMachine = {}
StateMachine.__index = StateMachine

-- 状态定义
local PlayerState = {
    IDLE = "idle",                    -- 空闲状态
    WAITING_INPUT = "waiting_input",  -- 等待输入
    PROCESSING_COMMAND = "processing_command", -- 处理命令中
    FLOW_ACTIVE = "flow_active",      -- 流程进行中
    TOOL_ACTION = "tool_action",      -- 道具操作中
}

-- 流程定义
local FlowType = {
    FOLD_CONFIG = "fold_config",          -- 折轨配置
    PATTERN_RENAME = "pattern_rename",    -- Pattern重命名
    AREAPAT_RENAME = "areapat_rename",    -- AreaPAT重命名
    SETTING_OFFSET = "setting_offset",    -- 设置偏移
    SETTING_PITCH = "setting_pitch",      -- 设置调性
    MEASURE_SETUP = "measure_setup",      -- 小节标记设置
    TRACK_SEAL = "track_seal",            -- 封轨/拆轨
    -- 可根据需要扩展
}

function StateMachine:Initialize()
    self.flows = {}  -- 流程处理器注册表
    self.eventHandlers = {}  -- 事件处理器注册表
    
    -- 注册流程处理器
    self:RegisterFlow(FlowType.FOLD_CONFIG, require("Modules.FoldConfig"))
    self:RegisterFlow(FlowType.PATTERN_RENAME, require("Modules.Pattern.FlowHandler"))
    -- ... 其他流程
    
    -- 注册事件处理器
    self:RegisterEventHandler("tool_selected", self.OnToolSelected)
    self:RegisterEventHandler("block_click", self.OnBlockClick)
    -- ... 其他事件
end

-- 注册流程处理器
function StateMachine:RegisterFlow(flowType, handler)
    self.flows[flowType] = handler
end

-- 注册事件处理器
function StateMachine:RegisterEventHandler(eventType, handler)
    self.eventHandlers[eventType] = handler
end

-- 玩家进入游戏
function StateMachine:OnPlayerEnter(UIN)
    local session = require("Core.PlayerSession"):GetSession(UIN)
    if not session then return end
    
    -- 初始化玩家状态
    session.state = PlayerState.IDLE
    session.currentFlow = nil
    
    -- 设置玩家飞行
    Player:changPlayerMoveType(UIN, 1)
    
    -- 给玩家添加道具
    self:GivePlayerItems(UIN)
    
    -- 显示欢迎信息
    self:ShowWelcomeMessage(UIN)
end

-- 玩家离开游戏
function StateMachine:OnPlayerLeave(UIN)
    local session = require("Core.PlayerSession"):GetSession(UIN)
    if session then
        -- 清理流程
        if session.currentFlow then
            self:CancelFlow(session)
        end
        session.state = PlayerState.IDLE
    end
end

-- 开始流程
function StateMachine:StartFlow(session, flowType, initialData)
    if not self.flows[flowType] then
        error("Unknown flow type: " .. tostring(flowType))
    end
    
    local handler = self.flows[flowType]
    session.currentFlow = {
        type = flowType,
        handler = handler,
        step = 1,
        data = initialData or {},
        startTime = os.time(),
        expireAt = os.time() + 60, -- 默认60秒超时
    }
    session.state = PlayerState.FLOW_ACTIVE
    
    -- 调用流程的入口
    if handler.OnEnter then
        handler:OnEnter(session, session.currentFlow)
    end
end

-- 取消流程
function StateMachine:CancelFlow(session)
    if not session.currentFlow then return end
    
    local handler = session.currentFlow.handler
    if handler and handler.OnCancel then
        handler:OnCancel(session, session.currentFlow)
    end
    
    session.currentFlow = nil
    session.state = PlayerState.IDLE
end

-- 处理流程输入
function StateMachine:HandleFlowInput(session, input)
    if not session.currentFlow then
        return false -- 没有活跃流程
    end
    
    local flow = session.currentFlow
    local handler = flow.handler
    
    -- 检查超时
    if os.time() > flow.expireAt then
        self:CancelFlow(session)
        require("Utils.I18N"):SendMessage(session.UIN, "flow_timeout")
        return true
    end
    
    -- 调用流程处理器
    if handler.OnInput then
        local result = handler:OnInput(session, flow, input)
        if result == "complete" then
            -- 流程完成
            if handler.OnComplete then
                handler:OnComplete(session, flow)
            end
            session.currentFlow = nil
            session.state = PlayerState.IDLE
        elseif result == "cancel" then
            -- 流程取消
            self:CancelFlow(session)
        end
        return true
    end
    
    return false
end

-- 清理超时流程
function StateMachine:CleanupExpiredFlows()
    local PlayerSession = require("Core.PlayerSession")
    local allSessions = PlayerSession:GetAllSessions()
    
    local now = os.time()
    for UIN, session in pairs(allSessions) do
        if session.currentFlow and now > session.currentFlow.expireAt then
            self:CancelFlow(session)
        end
    end
end

-- 工具选择事件
function StateMachine:OnToolSelected(session, itemId)
    -- 取消当前流程（如果切换工具）
    if session.currentFlow then
        -- 某些工具切换时需要保留流程，这里可以根据需要调整
        -- self:CancelFlow(session)
    end
    
    session.currentTool = itemId
    session.state = PlayerState.TOOL_ACTION
    
    -- 触发工具特定的处理
    local handler = self.eventHandlers["tool_selected"]
    if handler then
        handler(self, session, itemId)
    end
end

-- 方块点击事件
function StateMachine:OnBlockClick(session, blockId, x, y, z)
    local handler = self.eventHandlers["block_click"]
    if handler then
        handler(self, session, blockId, x, y, z)
    end
end

-- 方块挖掘事件
function StateMachine:OnBlockDigBegin(session, blockId, x, y, z)
    local handler = self.eventHandlers["block_dig_begin"]
    if handler then
        handler(self, session, blockId, x, y, z)
    end
end

-- 道具使用事件
function StateMachine:OnItemUse(session, itemId)
    local handler = self.eventHandlers["item_use"]
    if handler then
        handler(self, session, itemId)
    end
end

-- 给玩家添加道具
function StateMachine:GivePlayerItems(UIN)
    local Constants = require("Utils.Constants")
    local itemList = Constants.ItemId.INITIAL_ITEMS
    
    for _, itemId in ipairs(itemList) do
        local has1 = Backpack:hasItemByBackpackBar(UIN, 1, itemId)
        local has2 = Backpack:hasItemByBackpackBar(UIN, 2, itemId)
        if has1 ~= 0 and has2 ~= 0 then
            Player:gainItems(UIN, itemId, 1, 1)
        end
    end
end

-- 显示欢迎信息
function StateMachine:ShowWelcomeMessage(UIN)
    local I18N = require("Utils.I18N")
    local messages = I18N:Get("intro")
    for _, msg in ipairs(messages) do
        Chat:sendSystemMsg(msg, UIN)
        Trigger:wait(0.1)
    end
end

return StateMachine

