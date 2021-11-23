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
    [41] = "other/center",
    [42] = "other/mart",
    [43] = "other/bike",
    [44] = "numbers/1",
    [45] = "numbers/2",
    [46] = "numbers/3",
    [47] = "numbers/4",
    [48] = "numbers/5",
    [49] = "numbers/6",
    [50] = "numbers/7",
    [51] = "numbers/8",
    [52] = "locations/oldale",
    [53] = "locations/petalburg",
    [54] = "locations/rustboro",
    [55] = "locations/dewford",
    [56] = "locations/slateport",
    [57] = "locations/mauville",
    [58] = "locations/verdanturf",
    [59] = "locations/lavaridge",
    [60] = "locations/fallarbor",
    [61] = "locations/fortree",
    [62] = "locations/lilycove",
    [63] = "locations/mossdeep",
    [64] = "locations/sootopolis",
    [65] = "locations/pacifidlog",
    [66] = "locations/ever_grande",
    [67] = "locations/route_104",
    [68] = "locations/route_105",
    [69] = "locations/route_106",
    [70] = "locations/route_108",
    [71] = "locations/route_109",
    [72] = "locations/route_110",
    [73] = "locations/route_111",
    [74] = "locations/route_112",
    [75] = "locations/route_113",
    [76] = "locations/route_114",
    [77] = "locations/route_115",
    [78] = "locations/route_116",
    [79] = "locations/route_117",
    [80] = "locations/route_119",
    [81] = "locations/route_120",
    [82] = "locations/route_122",
    [83] = "locations/route_123",
    [84] = "locations/route_124",
    [85] = "locations/underwater",
    [86] = "locations/aqua_hideout",
    [87] = "locations/granite",
    [88] = "locations/jagged_pass",
    [89] = "locations/magma_hideout",
    [90] = "locations/meteor_falls",
    [91] = "locations/mirage_tower",
    [92] = "locations/navel_rock",
    [93] = "locations/petalburg_woods",
    [94] = "locations/mt_pyre",
    [95] = "locations/rusturf_tunnel",
    [96] = "locations/seafloor_cavern",
    [97] = "locations/abandoned_ship",
    [98] = "locations/sky_pillar",
    [99] = "locations/victory_road",
    [100] = "locations/dept"
}
DoorSlot.Selection = "slot_ship_1f_w_stairs"

function DoorSlot:init(roomSlot, doorSlot)
    self:createItem("Door Slot")
    self.code = "slot_" .. roomSlot .. "_" .. doorSlot
    self.roomSlot = roomSlot
    self.doorSlot = doorSlot
    self.hubIcon = nil

    self:setState(1)
end

function DoorSlot:setHubIcon(hubIcon)
    self.hubIcon = hubIcon
end

function DoorSlot:setSelection()
    DoorSlot.Selection = self.code
end

function DoorSlot:removeSelectionOverlay()
    local current_warp = Tracker:FindObjectForCode(DoorSlot.Selection).ItemState
    local state = current_warp:getState()
    if state < 52 then
        current_warp.ItemInstance.Icon = ImageReference:FromPackRelativePath("images/" .. DoorSlot.Icons[state] .. ".png", "")
    else
        current_warp = Tracker:FindObjectForCode("hub" .. DoorSlot.Selection).ItemState
        current_warp.ItemInstance.Icon = ImageReference:FromPackRelativePath("images/" .. DoorSlot.Icons[state] .. ".png", "")
    end
end

function DoorSlot:addSelectionOverlay()
    local state = self:getState()
    if state < 52 then
        local current_warp = Tracker:FindObjectForCode(DoorSlot.Selection).ItemState
        current_warp.ItemInstance.Icon = ImageReference:FromPackRelativePath("images/" .. DoorSlot.Icons[state] .. ".png", "overlay|images/other/selected_tag.png")
    else
        local current_warp = Tracker:FindObjectForCode("hub" .. DoorSlot.Selection).ItemState
        current_warp.ItemInstance.Icon = ImageReference:FromPackRelativePath("images/" .. DoorSlot.Icons[state] .. ".png", "overlay|images/other/selected_hub.png")
    end
end

function DoorSlot:setState(state)
    self:setProperty("state", state)
end

function DoorSlot:getState()
    return self:getProperty("state")
end

function DoorSlot:updateIcon()
    if self:getState() < 52 then
        local img = DoorSlot.Icons[self:getState()]
        local imgPath = "images/" .. img .. ".png"
        local overlay = ""
        if self.code == DoorSlot.Selection then
            overlay = "overlay|images/other/selected_tag.png"
        end
        self.ItemInstance.Icon = ImageReference:FromPackRelativePath(imgPath, overlay)
    else
        self.ItemInstance.Icon = nil
    end
end

function DoorSlot:onLeftClick()
    self:removeSelectionOverlay()
    self:setSelection()
    self:addSelectionOverlay()
end

function DoorSlot:onRightClick()
    local state = DoorSlotSelection.Selection
    self:setState(state)
    self.hubIcon:setState(state)
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
    end
end
