DoorSlotSelection = CustomItem:extend()
DoorSlotSelection.Types = {
    [1] = "unknown",
    [2] = "one_way",
    [3] = "dead_end",
    [4] = "event",
    [5] = "trainer",
    [6] = "stone_badge",
    [7] = "knuckle_badge",
    [8] = "dynamo_badge",
    [9] = "heat_badge",
    [10] = "balance_badge",
    [11] = "feather_badge",
    [12] = "mind_badge",
    [13] = "rain_badge",
    [14] = "e4_dark",
    [15] = "e4_ghost",
    [16] = "e4_ice",
    [17] = "e4_dragon",
    [18] = "champ_water",
    [19] = "steven_steel",
    [20] = "rock_smash",
    [21] = "strength",
    [22] = "surf",
    [23] = "waterfall",
    [24] = "dive",
    [25] = "hm1",
    [26] = "hm2",
    [27] = "hm3",
    [28] = "hm4",
    [29] = "hm5",
    [30] = "hm6",
    [31] = "hm7",
    [32] = "hm8",
    [33] = "custom1",
    [34] = "custom2",
    [35] = "custom3",
    [36] = "custom4",
    [37] = "custom5",
    [38] = "custom6",
    [39] = "custom7",
    [40] = "custom8",
    [41] = "center",
    [42] = "mart",
    [43] = "bike",
    [44] = "1",
    [45] = "2",
    [46] = "3",
    [47] = "4",
    [48] = "5",
    [49] = "6",
    [50] = "7",
    [51] = "8",
    [52] = "oldale",
    [53] = "petalburg",
    [54] = "rustboro",
    [55] = "dewford",
    [56] = "slateport",
    [57] = "mauville",
    [58] = "verdanturf",
    [59] = "lavaridge",
    [60] = "fallarbor",
    [61] = "fortree",
    [62] = "lilycove",
    [63] = "mossdeep",
    [64] = "sootopolis",
    [65] = "pacifidlog",
    [66] = "ever_grande",
    [67] = "route_104",
    [68] = "route_105",
    [69] = "route_106",
    [70] = "route_108",
    [71] = "route_109",
    [72] = "route_110",
    [73] = "route_111",
    [74] = "route_112",
    [75] = "route_113",
    [76] = "route_114",
    [77] = "route_115",
    [78] = "route_116",
    [79] = "route_117",
    [80] = "route_119",
    [81] = "route_120",
    [82] = "route_122",
    [83] = "route_123",
    [84] = "route_124",
    [85] = "underwater",
    [86] = "aqua_hideout",
    [87] = "granite",
    [88] = "jagged_pass",
    [89] = "magma_hideout",
    [90] = "meteor_falls",
    [91] = "mirage_tower",
    [92] = "navel_rock",
    [93] = "petalburg_woods",
    [94] = "mt_pyre",
    [95] = "rusturf_tunnel",
    [96] = "seafloor_cavern",
    [97] = "abandoned_ship",
    [98] = "sky_pillar",
    [99] = "victory_road",
    [100] = "dept"
}
DoorSlotSelection.Selection = 2

function DoorSlotSelection:init(index)
    self:createItem("Door Slot Selection")
    self.index = index
    self.code = "doorslot_" .. DoorSlotSelection.Types[index]
    self.image = DoorSlot.Icons[index]

    self:setState(0)
end

function DoorSlotSelection:setState(state)
    self:setProperty("state", state)
end

function DoorSlotSelection:getState()
    return self:getProperty("state")
end

function DoorSlotSelection:updateIcon()
    local overlay = ""
    if self:getState() > 0 then
        if DoorSlotSelection.Selection < 52 then
            overlay = "overlay|images/other/selected_tag.png"
        else
            overlay = "overlay|images/other/selected_hub.png"
        end
    end

    self.ItemInstance.Icon = ImageReference:FromPackRelativePath("images/" .. self.image .. ".png", overlay)
end

function DoorSlotSelection:updateNeighbors()
    for i = 1, #DoorSlot.Icons do
        if DoorSlotSelection.Types[i] and self.index ~= i then
            local item = Tracker:FindObjectForCode("doorslot_" .. DoorSlotSelection.Types[i])
            if item then
                item.ItemState:setState(0)
            end
        end
    end
end

function DoorSlotSelection:onLeftClick()
    local selection = self.index
    local current_warp = Tracker:FindObjectForCode(DoorSlot.Selection).ItemState
    local current_warp_hub = current_warp.hubIcon
    if current_warp and current_warp_hub then
        current_warp:setState(selection)
        current_warp_hub:setState(selection)
        if selection < 52 then
            current_warp.ItemInstance.Icon = ImageReference:FromPackRelativePath("images/" .. DoorSlot.Icons[selection] .. ".png", "overlay|images/other/selected_tag.png")
        else
            current_warp_hub.ItemInstance.Icon = ImageReference:FromPackRelativePath("images/" .. DoorSlot.Icons[selection] .. ".png", "overlay|images/other/selected_hub.png")
        end
    end
end

function DoorSlotSelection:onRightClick()
    DoorSlotSelection.Selection = self.index
    self:setState(1)
    self:updateNeighbors()
end

function DoorSlotSelection:canProvideCode(code)
    if code == self.code then
        return true
    else
        return false
    end
end

function DoorSlotSelection:providesCode(code)
    if code == self.code and self:getState() ~= 0 then
        return self:getState()
    end
    return 0
end

function DoorSlotSelection:advanceToCode(code)
    if code == nil or code == self.code then
        self:setState((self:getState() + 1) % 2)
    end
end

function DoorSlotSelection:propertyChanged(key, value)
    if key == "state" then
        self:updateIcon()
    end
end
