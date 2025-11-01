--[[
    命令路由器
    负责命令解析、路由分发
]]

local CommandRouter = {}
CommandRouter.__index = CommandRouter

local globalCommands = {}  -- 全局命令（不依赖道具）
local toolCommands = {}    -- 工具命令（按道具ID分组）

function CommandRouter:Initialize()
    -- 注册全局命令
    self:RegisterGlobalCommand("id", require("Commands.Global.ShowId"))
    self:RegisterGlobalCommand("clear", require("Commands.Global.ClearInstrumentData"))
    
    -- 注册工具命令
    self:RegisterToolCommand(690, "tone", require("Commands.ToneBlock.ToneCommand"))  -- 低音块
    self:RegisterToolCommand(691, "tone", require("Commands.ToneBlock.ToneCommand"))  -- 中音块
    self:RegisterToolCommand(692, "tone", require("Commands.ToneBlock.ToneCommand"))  -- 高音块
    
    self:RegisterToolCommand(11580, "instrument", require("Commands.InstrumentBlock.InstrumentCommand"))  -- 平凡法杖
    
    -- ... 其他工具命令注册
end

-- 注册全局命令
function CommandRouter:RegisterGlobalCommand(name, handler)
    globalCommands[name] = handler
end

-- 注册工具命令
function CommandRouter:RegisterToolCommand(itemId, category, handler)
    if not toolCommands[itemId] then
        toolCommands[itemId] = {}
    end
    toolCommands[itemId][category] = handler
end

-- 路由命令
function CommandRouter:Route(session, input)
    local StateMachine = require("Core.StateMachine")
    local sm = StateMachine
    
    -- 优先级1: 检查是否有活跃流程
    if session.currentFlow then
        local handled = sm:HandleFlowInput(session, input)
        if handled then
            return
        end
    end
    
    -- 优先级2: 检查工具命令
    if session.currentTool then
        local handlers = toolCommands[session.currentTool]
        if handlers then
            for category, handler in pairs(handlers) do
                local result = handler:Process(session, input)
                if result == "handled" then
                    return
                end
            end
        end
    end
    
    -- 优先级3: 检查全局命令
    local lowerInput = string.lower(input)
    for name, handler in pairs(globalCommands) do
        if lowerInput == name or input:match("^/" .. name) then
            handler:Process(session, input)
            return
        end
    end
    
    -- 未匹配到任何命令，可以在这里处理未知命令提示
end

return CommandRouter

