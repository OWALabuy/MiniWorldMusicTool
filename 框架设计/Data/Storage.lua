--[[
    数据存储管理
    管理Pattern、AreaPAT等持久化数据
]]

local Storage = {}
Storage.__index = Storage

local patternData = {
    count = 0,
    data = {},  -- patternData.data[patId] = { ... }
}

local areaPatternData = {
    count = 0,
    data = {},  -- areaPatternData.data[patId] = { ... }
}

function Storage:Initialize()
    -- 可以从存档加载数据（如果有持久化需求）
    patternData = {
        count = 0,
        data = {},
    }
    areaPatternData = {
        count = 0,
        data = {},
    }
end

-- Pattern相关操作
function Storage:CreatePattern(name, authorName, authorUIN, pos, vector, direction, areadata)
    patternData.count = patternData.count + 1
    local patId = patternData.count
    
    patternData.data[patId] = {
        id = patId,
        name = name or ("pat" .. patId),
        authorName = authorName or "",
        authorUIN = authorUIN or 0,
        pos = pos,
        vector = vector,
        direction = direction,
        areadata = areadata,
    }
    
    return patId
end

function Storage:GetPattern(patId)
    return patternData.data[patId]
end

function Storage:GetAllPatterns()
    return patternData.data
end

function Storage:GetPatternCount()
    return patternData.count
end

function Storage:RenamePattern(patId, newName)
    if patternData.data[patId] then
        patternData.data[patId].name = newName
        return true
    end
    return false
end

function Storage:DeletePattern(patId)
    if patternData.data[patId] then
        patternData.data[patId] = nil
        return true
    end
    return false
end

-- AreaPAT相关操作（类似Pattern）
function Storage:CreateAreaPattern(name, authorName, authorUIN, pos, vector, direction, areadata)
    areaPatternData.count = areaPatternData.count + 1
    local patId = areaPatternData.count
    
    areaPatternData.data[patId] = {
        id = patId,
        name = name or ("areaPAT" .. patId),
        authorName = authorName or "",
        authorUIN = authorUIN or 0,
        pos = pos,
        vector = vector,
        direction = direction,
        areadata = areadata,
    }
    
    return patId
end

function Storage:GetAreaPattern(patId)
    return areaPatternData.data[patId]
end

function Storage:GetAllAreaPatterns()
    return areaPatternData.data
end

function Storage:GetAreaPatternCount()
    return areaPatternData.count
end

function Storage:RenameAreaPattern(patId, newName)
    if areaPatternData.data[patId] then
        areaPatternData.data[patId].name = newName
        return true
    end
    return false
end

function Storage:DeleteAreaPattern(patId)
    if areaPatternData.data[patId] then
        areaPatternData.data[patId] = nil
        return true
    end
    return false
end

return Storage

