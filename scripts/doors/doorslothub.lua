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

function DoorSlotHub:updateIcon()
    if self:getState() < 52 then
        self.ItemInstance.Icon = nil
    else
        local img = DoorSlot.Icons[self:getState()]
        local imgPath = "images/" .. img .. ".png"
        local overlay = ""
        if self.code == "hub" .. DoorSlot.Selection then
            overlay = "overlay|images/other/selected_hub.png"
        end
        self.ItemInstance.Icon = ImageReference:FromPackRelativePath(imgPath, overlay)
    end
end

function DoorSlotHub:onLeftClick()
    self.sqIcon:removeSelectionOverlay()
    self.sqIcon:setSelection()
    self.sqIcon:addSelectionOverlay()
end

function DoorSlotHub:onRightClick()
    local state = DoorSlotSelection.Selection
    self:setState(state)
    self.sqIcon:setState(state)
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
    end
end
