----------------------------- Setup -----------------------------

dofile("data/scripts/lib/utilities.lua") -- Base Utilities
dofile("mods/Ride Minecart/files/utilities.lua") -- My Utilities

local Physics_KEY = "MINECART_MOD_Physics"
local RidingKey = "MINECART_MOD_Riding"

Minecart = EntityGetWithName("minecart_modded")
Player = getPlayerEntity()

Physics = GlobalsGetValue(Physics_KEY, "0")
Riding = GlobalsGetValue(RidingKey, "0")

----------------------------- Set/Get Physics -----------------------------

function SetPhysics(PHY)
    GlobalsSetValue(Physics_KEY, tostring(PHY))
end

----------------------------- Update Physics -----------------------------

function MinecartPhysicsUpdate()
    if Physics == "0" then
        -- Minecart Vars
        local MineX, MineY, MineRot = EntityGetTransform(Minecart)
        local MinecartPhysicsComponent = EntityGetFirstComponentIncludingDisabled(Minecart, "PhysicsBodyComponent")
        local MinecartGrounded = RaytracePlatforms( MineX, MineY+9, MineX, MineY+10)

        -- Player Vars
        local PlyX, PlyY, PlyRot = EntityGetTransform(getPlayerEntity())

        -- Check Key Presses
        local controls_component = EntityGetFirstComponentIncludingDisabled(getPlayerEntity() , "ControlsComponent")

        local Apressed = ComponentGetValue2(controls_component, "mButtonDownLeft")
        local Dpressed = ComponentGetValue2(controls_component, "mButtonDownRight")

        local Wpressed = ComponentGetValue2(controls_component, "mButtonDownUp")
        local Spressed = ComponentGetValue2(controls_component, "mButtonDownDown")

        -- Key Press
        if MinecartGrounded == false then
            -- Left And Right
            if Apressed then
                PhysicsApplyTorque(Minecart,-10)
            end

            if Dpressed then
                PhysicsApplyTorque(Minecart,10)
            end
        else
            if Apressed then
                PhysicsApplyForce(Minecart,-10,0)
            end

            if Dpressed then
                PhysicsApplyForce(Minecart,10,0)
            end
        end

        -- Counter Physics
        local X,Y = PhysicsGetComponentVelocity(Minecart, MinecartPhysicsComponent)

        if MinecartGrounded == false then
            PhysicsApplyTorque(Minecart, -PhysicsGetComponentAngularVelocity(Minecart, MinecartPhysicsComponent)*2.5)
        else 
            PhysicsApplyForce(Minecart, -X/2,0)

            PhysicsApplyTorque(Minecart, -PhysicsGetComponentAngularVelocity(Minecart, MinecartPhysicsComponent)*10)
        end

        -- Controls player position
        EntitySetTransform(getPlayerEntity(), MineX, MineY, MineRot)
    end
end

function PlayerPhysicsUpdate()
    if Polymorphed() == true then
        local sprite = EntityGetFirstComponentIncludingDisabled(getPlayerEntity(), "SpriteComponent")
        local hitbox = EntityGetFirstComponentIncludingDisabled(getPlayerEntity(), "DamageModelComponent") --"HitboxComponent"

        local Phy = ComponentGetValue2(hitbox, "physics_objects_damage")

        if Physics == "0" then
            if Phy == true then
                ComponentSetValue2(sprite, "emissive", false)
                ComponentSetValue2(sprite, "additive", false)
                --ComponentSetValue(sprite, "z_index", 0.1)
                        
                ComponentSetValue2(hitbox, "physics_objects_damage", false)
            end
        else 
            if Phy == false then
                ComponentSetValue2(sprite, "emissive", true)
                ComponentSetValue2(sprite, "additive", true)
                --ComponentSetValue(sprite, "z_index", 0.1)
                        
                ComponentSetValue2(hitbox, "physics_objects_damage", true)
            end
        end
    end

    if Polymorphed() == false then
        -- Player Collsision
        local Component_Collision = EntityGetFirstComponentIncludingDisabled(getPlayerEntity(), "PlayerCollisionComponent")

        -- Player Sprite
        local Component_Sprite = EntityGetFirstComponentIncludingDisabled(getPlayerEntity(), "SpriteComponent")

        -- Physics Check
        local Phy = ComponentGetIsEnabled(Component_Collision)

        if Physics == "0" then
            if Phy == true then
                EntitySetComponentIsEnabled(getPlayerEntity(), Component_Collision, false)

                ComponentSetValue(Component_Sprite, "z_index", 1)
            end
        else
            if Phy == false then
                EntitySetComponentIsEnabled(getPlayerEntity(), Component_Collision, true)

                ComponentSetValue(Component_Sprite, "z_index", 0.6)
            end
        end
    end
end

----------------------------- Main -----------------------------

if Riding == "0" then
    SetPhysics(1)
else
    SetPhysics(0)
end

if Physics == "1" then
    PlyX, PlyY, PlyRot, PlyScaleX, PlyScaleY = EntityGetTransform(Player)

    if PlyRot ~= 0 then
        EntitySetTransform(getPlayerEntity(), PlyX, PlyY-7, 0)
    end
end

-- Update Minecart physics
MinecartPhysicsUpdate()

-- Update Player Physics
PlayerPhysicsUpdate()