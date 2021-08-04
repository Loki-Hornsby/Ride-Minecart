------------------------- Toggle a variable -------------------------
function Toggle(v)
    if v == true then
        return false
    else
        return true
    end
end

------------------------- Returns whether an entity is damaged -------------------------
function Damaged(PhysicsObj, original_pixel_count)
    -- Set Required damage for minecart to be "broken"
    local DamageRequire = 0
    local MineStrength = ModSettingGet("Ride Minecart.ui_Break")

    if MineStrength == "max" then
        DamageRequire = 1
    end

    if MineStrength == "4" then
        DamageRequire = 45
    end

    if MineStrength == "3" then
        DamageRequire = 20
    end

    if MineStrength == "2" then
        DamageRequire = 10
    end

    if MineStrength == "1" then
        DamageRequire = 1
    end

    -- Return if damaged
    local DesiredPercentage = DamageRequire

    local pixel_count = ComponentGetValue2(PhysicsObj, "mPixelCount")
    local CurrentDestruction = ((original_pixel_count - pixel_count) / original_pixel_count) * 100

    if CurrentDestruction < DesiredPercentage then
        return 0, ""
    else
        if CurrentDestruction > 80 then
            return CurrentDestruction, ""
        end
    
        if CurrentDestruction > 40 then
            return CurrentDestruction, "The Minecart Seems to be Fucked!"
        end
    
        if CurrentDestruction > 20 then
            return CurrentDestruction, "The Minecart Seems to be Broken!"
        end
    
        if CurrentDestruction > 10 then
            return CurrentDestruction, "The Minecart Seems to have a big hole in it!"
        end
    
        if CurrentDestruction > 1 then
            return CurrentDestruction, "The Minecart Seems to be Dinked!"
        end
    end
end

------------------------- Returns Player Entity -------------------------
function getPlayerEntity()
    local players = EntityGetWithTag("player_unit")

    if #players == 0 then 
        local tag = "polymorphed"
        local entities = EntityGetWithTag(tag)
        local player = entities[1]

        return player
    else
        PlayerLastX, PlayerLastY = EntityGetTransform(players[1])
    end

    return players[1]
end

------------------------- Check if player is polymorphed -------------------------
function Polymorphed()
    local isPolied = EntityHasTag(getPlayerEntity(), "polymorphed")
    if isPolied then
        return true
    else
        return false
    end
end