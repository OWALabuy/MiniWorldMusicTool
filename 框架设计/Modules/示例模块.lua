--[[
    模块示例：折轨配置流程
    展示如何使用状态机处理多步交互
]]

local FoldConfig = {}
FoldConfig.__index = FoldConfig

-- 流程步骤定义
local Step = {
    CHOOSE_DIRECTION = 1,      -- 选择方向
    SET_LEFT_TRACK = 2,        -- 设置左轨位置
    SET_RIGHT_TRACK = 3,       -- 设置右轨位置
    SET_OFFSET = 4,            -- 设置偏移量
}

-- 流程进入时调用
function FoldConfig:OnEnter(session, flow)
    local I18N = require("Utils.I18N")
    I18N:SendMultiLine(session.UIN, "tip.fold.tip1")
    I18N:SendMultiLine(session.UIN, "tip.fold.tip2")
    I18N:SendMultiLine(session.UIN, "tip.fold.tip3")
    I18N:SendMessage(session.UIN, "tip.fold.tip4")
    
    flow.step = Step.CHOOSE_DIRECTION
    flow.data = {
        axis = nil,
        direction = nil,
        leftTrackPos = nil,
        rightTrackPos = nil,
        offset = nil,
    }
end

-- 流程输入处理
function FoldConfig:OnInput(session, flow, input)
    local I18N = require("Utils.I18N")
    
    if flow.step == Step.CHOOSE_DIRECTION then
        -- 步骤1: 选择方向
        local num = tonumber(input)
        if num and num >= 1 and num <= 4 then
            local foldList = require("Utils.Constants").FoldList
            if foldList[num] then
                flow.data.axis = foldList[num].axis
                flow.data.direction = foldList[num].direction
                I18N:SendMessage(session.UIN, "tip.fold.chooseDirSuc")
                I18N:SendMessage(session.UIN, "tip.fold.trackTip")
                flow.step = Step.SET_LEFT_TRACK
                return "continue"
            end
        end
        I18N:SendMessage(session.UIN, "tip.fold.tip4")
        return "continue"
        
    elseif flow.step == Step.SET_LEFT_TRACK then
        -- 步骤2: 设置左轨位置
        local lowerInput = string.lower(input)
        if lowerInput == "l" then
            local _, x, y, z = Actor:getPosition(session.UIN)
            flow.data.leftTrackPos = {
                x = math.floor(x),
                y = math.floor(y),
                z = math.floor(z)
            }
            I18N:SendMessage(session.UIN, "tip.fold.trackTip3")
            flow.step = Step.SET_RIGHT_TRACK
            return "continue"
        end
        I18N:SendMessage(session.UIN, "tip.fold.trackTip2")
        return "continue"
        
    elseif flow.step == Step.SET_RIGHT_TRACK then
        -- 步骤3: 设置右轨位置
        local lowerInput = string.lower(input)
        if lowerInput == "r" then
            local _, x, y, z = Actor:getPosition(session.UIN)
            flow.data.rightTrackPos = {
                x = math.floor(x),
                y = math.floor(y),
                z = math.floor(z)
            }
            I18N:SendMessage(session.UIN, "tip.fold.trackTip4")
            flow.step = Step.SET_OFFSET
            return "continue"
        end
        I18N:SendMessage(session.UIN, "tip.fold.trackTip3")
        return "continue"
        
    elseif flow.step == Step.SET_OFFSET then
        -- 步骤4: 设置偏移量
        local num = tonumber(input)
        if num and num > 0 then
            flow.data.offset = num
            -- 保存到玩家数据
            local fold = session.data.fold or {}
            fold.axis = flow.data.axis
            fold.direction = flow.data.direction
            fold.leftTrackKeyPos = flow.data.leftTrackPos[flow.data.axis:lower()]
            fold.rightTrackKeyPos = flow.data.rightTrackPos[flow.data.axis:lower()]
            fold.offset = flow.data.offset
            fold.period = math.abs(fold.leftTrackKeyPos - fold.rightTrackKeyPos) * 2
            fold.leftTrackInPeriod = math.min(fold.leftTrackKeyPos, fold.rightTrackKeyPos) % fold.period
            fold.distance = fold.period / 2
            session.data.fold = fold
            
            I18N:SendMessage(session.UIN, "tip.fold.foldSuc")
            return "complete"
        end
        I18N:SendMessage(session.UIN, "tip.fold.tip4")
        return "continue"
    end
    
    return "continue"
end

-- 流程完成时调用
function FoldConfig:OnComplete(session, flow)
    -- 可以在这里做一些清理工作
end

-- 流程取消时调用
function FoldConfig:OnCancel(session, flow)
    local I18N = require("Utils.I18N")
    I18N:SendMessage(session.UIN, "flow_cancelled")
end

return FoldConfig

