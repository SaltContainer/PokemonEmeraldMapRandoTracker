DoorSlot = CustomItem:extend()
DoorSlot.Icons = {
    [0] = "none",
    [1] = "other/unknown",
    [2] = "other/one_way",
    [3] = "other/dead_end",
    [4] = "other/event",
    [5] = "other/trainer",
    [6] = "badges/stone_badge",
    [7] = "badges/knuckle_badge",
    [8] = "badges/dynamo_badge",
    [9] = "badges/heat_badge",
    [10] = "badges/balance_badge",
    [11] = "badges/feather_badge",
    [12] = "badges/mind_badge",
    [13] = "badges/rain_badge",
    [14] = "gyms/e4_dark",
    [15] = "gyms/e4_ghost",
    [16] = "gyms/e4_ice",
    [17] = "gyms/e4_dragon",
    [18] = "gyms/champ_water",
    [19] = "gyms/steven_steel",
    [20] = "hms/rock_smash",
    [21] = "hms/strength",
    [22] = "hms/surf",
    [23] = "hms/waterfall",
    [24] = "hms/dive",
    [25] = "hms/hm1",
    [26] = "hms/hm2",
    [27] = "hms/hm3",
    [28] = "hms/hm4",
    [29] = "hms/hm5",
    [30] = "hms/hm6",
    [31] = "hms/hm7",
    [32] = "hms/hm8",
    [33] = "types/normal",
    [34] = "types/fire",
    [35] = "types/grass",
    [36] = "types/electric",
    [37] = "types/poison",
    [38] = "types/fairy",
    [39] = "types/bug",
    [40] = "types/psychic",
    [41] = "locations/oldale",
    [42] = "locations/petalburg",
    [43] = "locations/rustboro",
    [44] = "locations/dewford",
    [45] = "locations/slateport",
    [46] = "locations/mauville",
    [47] = "locations/verdanturf",
    [48] = "locations/lavaridge",
    [49] = "locations/fallarbor",
    [50] = "locations/fortree",
    [51] = "locations/lilycove",
    [52] = "locations/mossdeep",
    [53] = "locations/sootopolis",
    [54] = "locations/pacifidlog",
    [55] = "locations/ever_grande",
    [56] = "locations/route_104",
    [57] = "locations/route_105",
    [58] = "locations/route_106",
    [59] = "locations/route_108",
    [60] = "locations/route_109",
    [61] = "locations/route_110",
    [62] = "locations/route_111",
    [63] = "locations/route_112",
    [64] = "locations/route_113",
    [65] = "locations/route_114",
    [66] = "locations/route_115",
    [67] = "locations/route_116",
    [68] = "locations/route_117",
    [69] = "locations/route_119",
    [70] = "locations/route_120",
    [71] = "locations/route_122",
    [72] = "locations/route_123",
    [73] = "locations/route_124",
    [74] = "locations/underwater",
    [75] = "locations/aqua_hideout",
    [76] = "locations/granite",
    [77] = "locations/jagged_pass",
    [78] = "locations/magma_hideout",
    [79] = "locations/meteor_falls",
    [80] = "locations/mirage_tower",
    [81] = "locations/navel_rock",
    [82] = "locations/petalburg_woods",
    [83] = "locations/mt_pyre",
    [84] = "locations/rusturf_tunnel",
    [85] = "locations/seafloor_cavern",
    [86] = "locations/abandoned_ship",
    [87] = "locations/sky_pillar",
    [88] = "locations/victory_road"
}

function DoorSlot:init(roomSlot, doorSlot, hubIcon)
    self:createItem("Door Slot")
    self.code = "slot_" .. roomSlot .. "_" .. doorSlot
    self.roomSlot = roomSlot
    self.doorSlot = doorSlot
    self.hubIcon = hubIcon

    self:setState(1)
end

function DoorSlot:setState(state)
    self:setProperty("state", state)
    self.hubIcon:setState(state)
end

function DoorSlot:getState()
    return self:getProperty("state")
end

function DoorSlot:setDisabled()
    self.ItemInstance.IgnoreUserInput = self:getState() == 0
end

function DoorSlot:updateIcon()
    if self:getState() < 41 then
        local img = DoorSlot.Icons[self:getState()]
        local imgPath = "images/" .. img .. ".png"
        self.ItemInstance.Icon = ImageReference:FromPackRelativePath(imgPath)
    else
        self.ItemInstance.Icon = nil
        self.hubIcon:updateIcon()
    end
end

function DoorSlot:onLeftClick()
    local state = self:getState()
    if DoorSlotSelection.Selection == 0 then
        state = (state % #DoorSlot.Icons) + 1
    else
        state = DoorSlotSelection.Selection
    end

    self:setState(state)
    self:updateIcon()
    refreshDoorSlots()
end

function DoorSlot:onRightClick()
    local state = self:getState()
    if DoorSlotSelection.Selection == 0 then
        state = (state - 2) % #DoorSlot.Icons + 1
    else
        state = 1
    end

    self:setState(state)
    self:updateIcon()
    refreshDoorSlots()
end

function DoorSlot:canProvideCode(code)
    if code == self.code then
        return true
    else
        return false
    end
end

function DoorSlot:providesCode(code)
    if code == self.code and self:getState() ~= 0 then
        return self:getState()
    end
    return 0
end

function DoorSlot:advanceToCode(code)
    if code == nil or code == self.code then
        self:setState((self:getState() + 1) % #self.Icons)
    end
end

function DoorSlot:propertyChanged(key, value)
    if key == "state" then
        self:updateIcon()
        self:setDisabled()
    end
end
