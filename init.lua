--------------------------------- Setup ---------------------------------

-- Utilities
dofile_once("data/scripts/lib/utilities.lua")

-- Spawns the Minecart
ModLuaFileAppend("data/scripts/biomes/mountain/mountain_hall.lua", "mods/Ride Minecart/files/ForceSpawn.lua")

-- Add custom materials
ModMaterialsFileAdd("mods/Ride Minecart/data/materials/materials.xml")

-- Runtime Settings

local RidingKey = "MINECART_MOD_Riding"

local PhysicsKey = "MINECART_MOD_Physics"

local DamageKey = "MINECART_MOD_Damage"
 
--------------------------------- Main Code ---------------------------------

function OnPlayerSpawned(player)
    local ply_x, ply_y = EntityGetTransform(player)

    -- Physics
    GlobalsSetValue(PhysicsKey, "1")

    -- Riding
    GlobalsSetValue(RidingKey, "0")

    -- Damage
    GlobalsSetValue(DamageKey, "0")

    -- Minecart Handling
    EntityLoad("mods/Ride Minecart/files/Minecart/minecart_handle.xml")

    -- Test
    --EntityLoad("mods/Ride Minecart/data/entities/props/physics/minecart.xml", 0, 0-400)
end
