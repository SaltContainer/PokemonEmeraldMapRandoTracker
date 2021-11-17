DoorSlotHub = CustomItem:extend()

function DoorSlotHub:init(roomSlot, doorSlot, sqIcon)
    self:createItem("Door Slot")
    self.code = "hubslot_" .. roomSlot .. "_" .. doorSlot
    self.roomSlot = roomSlot
    self.doorSlot = doorSlot
    self.sqIcon = sqIcon

    self:setState(1)
end

function DoorSlotHub:setState(state)
    self:setProperty("state", state)
    self.sqIcon:setState(state)
end

function DoorSlotHub:getState()
    return self:getProperty("state")
end

function DoorSlotHub:setDisabled()
    self.ItemInstance.IgnoreUserInput = self:getState() == 0
end

function DoorSlotHub:updateIcon()
    if self:getState() < 41 then
        self.ItemInstance.Icon = nil
    else
        local img = DoorSlot.Icons[self:getState()]
        local imgPath = "images/" .. img .. ".png"
        self.ItemInstance.Icon = ImageReference:FromPackRelativePath(imgPath)
    end
end

function DoorSlotHub:onLeftClick()
    local state = self:getState()
    if DoorSlotSelection.Selection == 0 then
        state = (state % #DoorSlot.Icons) + 1
    else
        state = DoorSlotSelection.Selection
    end

    self:setState(state)
    self.sqIcon:setState(state)
    self:updateIcon()
    self.sqIcon:updateIcon()
end

function DoorSlotHub:onRightClick()
    local state = self:getState()
    if DoorSlotSelection.Selection == 0 then
        state = (state - 2) % #DoorSlot.Icons + 1
    else
        state = 1
    end

    self:setState(state)
    self.sqIcon:setState(state)
    self:updateIcon()
    self.sqIcon:updateIcon()
end

function DoorSlotHub:canProvideCode(code)
    if code == self.code then
        return true
    else
        return false
    end
end

function DoorSlotHub:providesCode(code)
    if code == self.code and self:getState() ~= 0 then
        return self:getState()
    end
    return 0
end

function DoorSlotHub:advanceToCode(code)
    if code == nil or code == self.code then
        self:setState((self:getState() + 1) % #self.Icons)
    end
end

function DoorSlotHub:propertyChanged(key, value)
    if key == "state" then
        self:updateIcon()
        self:setDisabled()
    end
end
