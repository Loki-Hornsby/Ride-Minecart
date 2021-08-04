dofile("data/scripts/lib/utilities.lua") -- Base Utilities
dofile("mods/Ride Minecart/files/utilities.lua") -- My Utilities

function interacting(entity_who_interacted, entity_interacted, interactable_name)
    if interactable_name == "minecart_interact_claim" then
        Minecart = EntityGetWithName("minecart_modded")

        MineX, MineY, MineRot, MineScaleX, MineScaleY = EntityGetTransform(entity_interacted)
        OldMineX, OldMineY, OldMineRot, OldMineScaleX, OldMineScaleY = EntityGetTransform(Minecart)

        -- Kill Old minecart
        EntityKill(Minecart)

        -- Kill claimed minecart
        EntityKill(entity_interacted)

        -- Place old minecart Unclaimed
        EntityLoad("mods/Ride Minecart/data/entities/props/physics/minecart.xml", OldMineX, OldMineY, OldMineRot)

        -- Load new minecart Claimed
        local MineStrength = ModSettingGet("Ride Minecart.ui_Break")

        if MineStrength == "max" then
            EntityLoad("mods/Ride Minecart/files/Minecart/modded_minecart_unbreakable.xml", MineX, MineY)
        else
            EntityLoad("mods/Ride Minecart/files/Minecart/modded_minecart_breakable.xml", MineX, MineY)
        end

        -- Particles
        EntityLoad("data/entities/particles/particle_explosion/main.xml", MineX, MineY)
    end
    
    if interactable_name == "minecart_interact_enter" then
        local DamageKey = "MINECART_MOD_Damage"
        local Damage = GlobalsGetValue(DamageKey, "0")

        if tonumber(Damage) == 0 then
            local Interaction = EntityGetFirstComponent(entity_interacted, "InteractableComponent")
            
            local RidingKey = "MINECART_MOD_Riding"
            local Riding = GlobalsGetValue(RidingKey, "0")
            
            if Riding == "0" then
                GlobalsSetValue(RidingKey, "1")

                ComponentSetValue2(Interaction, "ui_text", "")
            else
                GlobalsSetValue(RidingKey, "0")
                
                local Strings = 
                {
                "Your trusty steel waits patiently....", 
                "Press $0 to enter!",
                "Don't stray too far!",
                "Clink Clink",
                "Kick Me!",
                "Find some dynamite",
                "Hide Behind me if your in danger!",
                "I'm actually called an orecart not a minecart! hmph!",
                "Bored of me already?",
                "leaving so quick?",
                "chink chink"
                }

                local st = Strings[math.random(1, #Strings)]

                ComponentSetValue2(Interaction, "ui_text", st)
            end   
        end
    end
end