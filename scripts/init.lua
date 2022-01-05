Tracker:AddItems("items/common.json")
Tracker:AddItems("items/maps.json")

Tracker:AddMaps("maps/maps.json")

ScriptHost:LoadScript("scripts/class.lua")
ScriptHost:LoadScript("scripts/global.lua")
ScriptHost:LoadScript("scripts/custom_item.lua")
ScriptHost:LoadScript("scripts/savestorage.lua")

ScriptHost:LoadScript("scripts/doors/doorslotselect.lua")
ScriptHost:LoadScript("scripts/doors/doorslothub.lua")
ScriptHost:LoadScript("scripts/doors/doorslot.lua")

ScriptHost:LoadScript("scripts/doors/loaddoorslots.lua")

Tracker:AddLayouts("layouts/items.json")
ScriptHost:LoadScript("scripts/load_door_layouts.lua")
Tracker:AddLayouts("layouts/map_tabs.json")
Tracker:AddLayouts("layouts/warp_icons.json")

Tracker:AddLayouts("layouts/tracker.json")

SaveStorage()