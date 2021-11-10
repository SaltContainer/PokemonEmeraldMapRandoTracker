Tracker:AddItems("items/common.json")
Tracker:AddItems("items/capture_locations.json")

Tracker:AddMaps("maps/maps.json")

ScriptHost:LoadScript("scripts/class.lua")
ScriptHost:LoadScript("scripts/custom_item.lua")

Tracker:AddLayouts("layouts/items.json")

ScriptHost:LoadScript("scripts/loadlocations.lua")

Tracker:AddLayouts("layouts/tracker.json")