--[[
    命令处理示例：显示手持道具信息
    展示如何实现一个简单的全局命令
]]

local ShowId = {}
ShowId.__index = ShowId

function ShowId:Process(session, input)
    local result, id = Player:getCurToolID(session.UIN)
    if result == 0 and id then
        local result2, name = Item:getItemName(id)
        if result2 == 0 and name then
            local I18N = require("Utils.I18N")
            I18N:SendMessage(session.UIN, "tip.item.getCurToolID", name, id)
            return "handled"
        end
    end
    return "not_handled"
end

return ShowId

