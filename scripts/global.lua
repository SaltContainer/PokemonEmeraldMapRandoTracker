DOORSLOTS = {}

function JObjectToLuaTable(obj)
    local ret = {}
    if obj:GetType():ToString() == "Newtonsoft.Json.Linq.JObject" then
        local vals = obj:GetValue("Values")
        local curKey = obj:GetValue("Keys").First
        local curVal = vals.First
        while (true)
        do
            ret[curKey:ToString()] = tonumber(curVal:ToString())
            if curVal == vals.Last then
                break
            else
                curKey = curKey.Next
                curVal = curVal.Next
            end
        end
    end
    return ret
end

function reloadDoorSlots()
    for k, v in pairs(DOORSLOTS) do
        local slot = Tracker:FindObjectForCode(k)
        slot.ItemState:manualRightClick(v)
    end
end