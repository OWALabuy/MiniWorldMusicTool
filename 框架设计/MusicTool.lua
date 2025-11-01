--[[
    『异端世方』音乐方块生成器 v2.0
    主脚本组件 - 挂载到世界对象上
]]

local Script = {}
local Core = require("Core.StateMachine")
local PlayerSession = require("Core.PlayerSession")
local CommandRouter = require("Core.CommandRouter")
local I18N = require("Utils.I18N")
local Storage = require("Data.Storage")

-- 组件启动时调用
function Script:OnStart()
    -- 初始化核心系统
    Core:Initialize()
    Storage:Initialize()
    
    -- 注册全局事件监听
    self:AddEvent(ObjectEvent.PlayerEnterWorld, self.OnPlayerEnter)
    self:AddEvent(ObjectEvent.PlayerLeaveWorld, self.OnPlayerLeave)
    self:AddEvent(ObjectEvent.PlayerNewInputContent, self.OnPlayerInput)
    self:AddEvent(ObjectEvent.PlayerSelectShortcut, self.OnPlayerSelectShortcut)
    self:AddEvent(ObjectEvent.PlayerClickBlock, self.OnPlayerClickBlock)
    self:AddEvent(ObjectEvent.PlayerDigBlockBegin, self.OnPlayerDigBlockBegin)
    self:AddEvent(ObjectEvent.PlayerUseItem, self.OnPlayerUseItem)
    self:AddEvent(ObjectEvent.GameRunTime, self.OnGameRunTime)
    
    -- 初始化命令路由
    CommandRouter:Initialize()
    
    print("[MusicTool] 系统初始化完成")
end

-- 玩家进入世界
function Script:OnPlayerEnter(event)
    local UIN = event.CurEventParam.objid
    PlayerSession:CreateSession(UIN)
    Core:OnPlayerEnter(UIN)
end

-- 玩家离开世界
function Script:OnPlayerLeave(event)
    local UIN = event.CurEventParam.objid
    PlayerSession:DestroySession(UIN)
    Core:OnPlayerLeave(UIN)
end

-- 玩家输入内容
function Script:OnPlayerInput(event)
    local UIN = event.CurEventParam.objid
    local content = event.content
    
    local session = PlayerSession:GetSession(UIN)
    if not session then return end
    
    -- 路由命令处理
    CommandRouter:Route(session, content)
end

-- 玩家选择快捷栏
function Script:OnPlayerSelectShortcut(event)
    local UIN = event.CurEventParam.objid
    local itemId = event.itemid
    
    local session = PlayerSession:GetSession(UIN)
    if not session then return end
    
    -- 触发工具选择事件
    Core:OnToolSelected(session, itemId)
end

-- 玩家点击方块
function Script:OnPlayerClickBlock(event)
    local UIN = event.CurEventParam.objid
    local blockId = event.blockid
    local x, y, z = event.x, event.y, event.z
    
    local session = PlayerSession:GetSession(UIN)
    if not session then return end
    
    -- 触发方块点击事件
    Core:OnBlockClick(session, blockId, x, y, z)
end

-- 玩家开始挖掘方块
function Script:OnPlayerDigBlockBegin(event)
    local UIN = event.CurEventParam.objid
    local blockId = event.blockid
    local x, y, z = event.x, event.y, event.z
    
    local session = PlayerSession:GetSession(UIN)
    if not session then return end
    
    -- 触发方块挖掘事件
    Core:OnBlockDigBegin(session, blockId, x, y, z)
end

-- 玩家使用道具
function Script:OnPlayerUseItem(event)
    local UIN = event.CurEventParam.objid
    local itemId = event.itemid
    
    local session = PlayerSession:GetSession(UIN)
    if not session then return end
    
    -- 触发道具使用事件
    Core:OnItemUse(session, itemId)
end

-- 游戏运行时间（定时任务）
function Script:OnGameRunTime(event)
    -- 定期清理超时流程
    Core:CleanupExpiredFlows()
end

return Script

