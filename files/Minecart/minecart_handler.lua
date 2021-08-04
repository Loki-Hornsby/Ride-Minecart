dofile("data/scripts/lib/utilities.lua") -- Base Utilities
dofile("mods/Ride Minecart/files/utilities.lua") -- My Utilities
dofile("mods/Ride Minecart/files/physicshandle.lua") -- Physics
dofile("mods/Ride Minecart/files/GUI.lua") -- GUI

-- Variables

Minecart = EntityGetWithName("minecart_modded")

if EntityGetIsAlive(Minecart) then

    -- Variables
    local Player = getPlayerEntity()

    local MineX, MineY, MineRot, MineScaleX, MineScaleY = EntityGetTransform(Minecart)
    local PlyX, PlyY, PlyRot, PlyScaleX, PlyScaleY = EntityGetTransform(Player)

    Interaction = EntityGetFirstComponent(Minecart, "InteractableComponent")

    local DamageKey = "MINECART_MOD_Damage"
    local RidingKey = "MINECART_MOD_Riding"

    -- Dist = get_distance(PlyX, PlyY, MineX, MineY)

    -- Damage
    local physics_body_component = EntityGetFirstComponent(Minecart, "PhysicsBodyComponent")

    if pixel_count == nil then
        pixel_count = ComponentGetValue2(physics_body_component, "mPixelCount")  
    end

    local MineStrength = ModSettingGet("Ride Minecart.ui_Break")

    local Damage, DamageString = Damaged(physics_body_component, pixel_count)
    local StrDam = tostring(Damage)

    GlobalsSetValue(DamageKey, StrDam)

    -- Check if minecart is broken/damaged
    if Damage > 0 then
        GlobalsSetValue(RidingKey, "0")
        
        ComponentSetValue2(Interaction, "ui_text", DamageString)
    end

    -- Settings
end