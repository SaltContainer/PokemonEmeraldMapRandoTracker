SaveStorage = CustomItem:extend()

function SaveStorage:init()
    self:createItem("Save Storage")
end

function SaveStorage:save()
    local saveData = {}
    saveData["doorSlots"] = DOORSLOTS
    return saveData
end

function SaveStorage:load(data)
    DOORSLOTS = JObjectToLuaTable(data["doorSlots"])
    reloadDoorSlots()
end
