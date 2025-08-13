local function H(str)
    local Hmapping = {
        ["-1x"] = "C", ["-1j"] = "D", ["1x"] = "E", ["1j"] = "F",
        ["2x"] = "G", ["2j"] = "A", ["3x"] = "B", ["3j"] = "C",
        ["4x"] = "D", ["4j"] = "E", ["5x"] = "F", ["+1j"] = "G",
        ["+1x"] = "A", ["+2j"] = "B"
    }
    
    local result = {}
    
    for k, v in ipairs(str) do
        result[k] = Hmapping[v]
    end
    
    for i = 1, #result do
        print(result[i])  
    end
end

--使用示例
s={"3j","4j","4j","4j","4x","4j","4x","4j","4j","4x","4j","4x"}
H(s)
