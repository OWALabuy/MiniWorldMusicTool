--[[
    国际化模块
    管理多语言文案
]]

local I18N = {}
I18N.__index = I18N

local currentLang = 1  -- 1: 简体中文, 2: English

-- 文案定义（从原代码迁移）
local messages = {
    -- 提示信息
    tip = {
        copy = {
            copySuccessfully = {
                "#cFFE1E1复制区域内所有音乐方块成功，区域起点(%d,%d,%d)",
                "#cFFE1E1Copy all music blocks in the area successfully, the starting position of the area is (%d,%d,%d)"
            },
            -- ... 其他文案
        },
        -- ... 其他分类
    },
    
    -- 使用说明
    readme = {
        -- ... 从原代码迁移
    },
    
    -- 道具介绍
    itemIntro = {
        -- ... 从原代码迁移
    },
    
    -- 欢迎信息
    intro = {
        -- ... 从原代码迁移
    },
    
    -- 错误信息
    error = {
        flow_timeout = {
            "#cFF0000流程已超时，已自动取消",
            "#cFF0000Flow timeout, automatically cancelled"
        },
        invalid_input = {
            "#cFF0000输入无效",
            "#cFF0000Invalid input"
        },
        -- ... 其他错误信息
    },
}

-- 获取当前语言
function I18N:GetCurrentLang()
    return currentLang
end

-- 设置语言
function I18N:SetLang(lang)
    if lang == 1 or lang == 2 then
        currentLang = lang
    end
end

-- 获取文案（支持嵌套路径）
function I18N:Get(path, ...)
    local parts = {}
    for part in path:gmatch("[^%.]+") do
        table.insert(parts, part)
    end
    
    local value = messages
    for _, part in ipairs(parts) do
        if type(value) == "table" then
            value = value[part]
        else
            return nil
        end
    end
    
    if type(value) == "table" and value[currentLang] then
        local text = value[currentLang]
        if select("#", ...) > 0 then
            return string.format(text, ...)
        else
            return text
        end
    elseif type(value) == "string" then
        return value
    end
    
    return nil
end

-- 发送消息给玩家
function I18N:SendMessage(UIN, path, ...)
    local msg = self:Get(path, ...)
    if msg then
        Chat:sendSystemMsg(msg, UIN)
    end
end

-- 发送通知给玩家
function I18N:SendNotify(UIN, path, ...)
    local msg = self:Get(path, ...)
    if msg then
        Player:notifyGameInfo2Self(UIN, msg)
    end
end

-- 发送多行消息（用于长文本）
function I18N:SendMultiLine(UIN, path, ...)
    local lines = self:Get(path, ...)
    if type(lines) == "table" then
        for i, line in ipairs(lines) do
            if type(line) == "string" then
                Chat:sendSystemMsg(line, UIN)
            elseif type(line) == "table" and line[currentLang] then
                Chat:sendSystemMsg(line[currentLang], UIN)
            end
            if i >= 3 then
                Trigger:wait(#(line or "") * 0.03)
            else
                Trigger:wait(0.1)
            end
        end
    end
end

return I18N

